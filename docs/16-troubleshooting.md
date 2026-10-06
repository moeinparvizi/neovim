# فصل ۱۶ — عیب‌یابی

## آیکون‌ها مربع‌اند؟

فونت Nerd Font نصب نیست یا ترمینال از آن استفاده نمی‌کند.
`brew install --cask font-jetbrains-mono-nerd-font` و فونت ترمینال را عوض کنید.

## فارسی جدا-جدا/خراب رندر می‌شود؟

مشکل ترمینال است نه nvim. kitty یا WezTerm یا iTerm2 استفاده کنید (فصل ۱۳).

## بعد از نصب اولیه، LSP کار نمی‌کند؟

```vim
:Mason          " vtsls و angularls نصب‌اند؟ اگر نه: MasonInstall vtsls angularls
:checkhealth
:LspInfo        " آیا سرور به فایل attach شده؟
```

اولین اجرا کمی طول می‌کشد (Mason در حال دانلود است). صبر کنید و nvim را باز-بسته کنید.

## اتوکامپلیت نیامد؟

`:Lazy` — وضعیت blink.cmp را ببینید (باید installed باشد). `:checkhealth blink` هم هست.

## «پول هوشمند» کانفلیکت را نشان نداد؟

مطمئن شوید داخل ریشه گیت هستید (`:pwd`). خطای شبکه/دسترسی در نوتیفیکیشن می‌آید. اگر rebase نیمه‌کاره ماند: `:Gabort` برگشت امن است.

## lazygit باز نمی‌شود؟

`brew install lazygit` — یا `<leader>gg` دوباره.

## فولد کار نمی‌کند / همه فولد هستند؟

`zR` باز کردن همه؛ `zM` بستن همه. اگر ufo لود نشد: `:Lazy` → nvim-ufo → وضعیت.

## پنچر ترمینال (Ctrl+Click و Alt+Click) کار نمی‌کند؟

بعضی ترمینال‌ها این رویدادها را خودشان می‌بلعند:
- **kitty**: پیش‌فرض اوکی. اگر Ctrl+Click باز شدن URL است، `mouse_map left press ...` را چک کنید.
- **iTerm2**: عالی (Default). Ctrl+Click = لینک ممکن است؛ در Settings → Pointer به آن bind ندهید.
- **WezTerm**: `mouse_bindings` را چک کنید.

## دیباگ شروع نشد؟

`:Mason` → `js-debug-adapter` نصب باشد. برای Attach: سرور با `--inspect`/`--inspect-brk` بالا آمده باشد (پورت ۹۲۲۹).

## LocalHistory خالی است؟

اسنپ‌شات‌ها بعد از هر `:w` گرفته می‌شوند. فایل جدید؟ اول ذخیره کنید. مسیر: `:lua print(vim.fn.stdpath('state'))` → پوشه `local-history`.

## تم ذخیره نشد؟

`<leader>ut` → Enter روی تم → فایل `~/.local/state/nvim/colorscheme.txt` باید نام تم باشد:
`:lua print(io.open(vim.fn.stdpath('state')..'/colorscheme.txt'):read('a'))`

## ریست کامل

```bash
mv ~/.config/nvim ~/.config/nvim.broken
git clone https://github.com/moeinparvizi/neovim.git ~/.config/nvim
rm -rf ~/.local/share/nvim ~/.local/state/nvim   # پاک کردن پلاگین‌ها (اختیاری، سنگین است)
nvim
```

## خطای «Query error … Invalid node type» موقع باز کردن فایل؟

متن خطا معمولاً این شکلیه: `Invalid node type "static_member_expression"` (یا هر node دیگری).

**دلیل:** پارسرهای کامپایل‌شدهٔ Treesitter از یک کانفیگ قدیمی‌تر روی دیسک مانده‌اند و با فایل‌های query پلاگین هماهنگ نیستند (معمولاً در `~/.local/share/nvim/site/parser/`).

**راه‌حل:**

```bash
# پارسرهای قدیمی را کنار بگذارید
mv ~/.local/share/nvim/site/parser ~/.local/share/nvim/site/parser.old-$(date +%Y%m%d)

# پارسرها را از نو با نسخهٔ درست کامپایل کنید
nvim --headless "+TSInstallSync! angular python javascript tsx typescript" +qa
nvim   # بعد باز کردن فایل، دیگر خطا نمی‌بینید
```

بررسی سریع اینکه همهٔ query ها سالم‌اند (باید `fails=0` چاپ کند):

```bash
nvim --headless "+lua vim.defer_fn(function() local f=0 for _,l in ipairs({'javascript','typescript','tsx','angular','python','lua'}) do if not pcall(vim.treesitter.query.get,l,'highlights') then f=f+1 print('FAIL '..l) end end print('fails='..f) vim.cmd('qa') end, 4000)"
```

## ابزارهای تشخیص

```vim
:checkhealth         " سلامت کل سیستم
:Lazy                " وضعیت پلاگین‌ها (خطاها قرمز)
:Mason               " نصب/وضعیت ابزارها
:messages            " لاگ پیام‌ها
:LspInfo             " سرورهای فایل جاری
:ConformInfo         " وضعیت فرمتر
:Notifications       " تاریخچه نوتیفیکیشن‌ها
```

بازگشت به [فهرست](README.md)
