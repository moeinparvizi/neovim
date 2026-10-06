# فصل ۱ — نصب و راه‌اندازی

## پیش‌نیازها

| ابزار | نقش | نصب |
|---|---|---|
| **Neovim ≥ 0.11** | خود ادیتور | `brew install neovim` |
| **Node.js ≥ 20** | LSPهای TypeScript/Angular | `brew install node` |
| **ripgrep** | جستجوی متن | `brew install ripgrep` |
| **fd** | پیدا کردن فایل | `brew install fd` |
| **lazygit** | UI گیت | `brew install lazygit` |
| **git** | که باشد! | `brew install git` |
| **A Nerd Font** | آیکون‌ها | [jetbrainsmono-nerd-font](https://www.nerdfonts.com/) — مثلاً `brew install --cask font-jetbrains-mono-nerd-font` |

> ⚠️ **فونت مهم است!** بدون Nerd Font، به جای آیکون‌ها مربع‌های خالی می‌بینید. برای فارسی هم فونت fallback مثل **Vazirmatn** نصب کنید (فصل ۱۳).

## نصب کانفیگ

```bash
# اگر کانفیگ قبلی دارید، بک‌آپ بگیرید
mv ~/.config/nvim ~/.config/nvim.bak

# کلون
git clone https://github.com/moeinparvizi/neovim.git ~/.config/nvim

# اجرا! پلاگین‌ها خودکار نصب می‌شوند (اولین بار چند دقیقه طول می‌کشد)
nvim
```

یا با اسکریپت آماده:

```bash
~/.config/nvim/install.sh
```

## اولین اجرا چه اتفاقی می‌افتد؟

1. **lazy.nvim** (مدیر پلاگین) همه پلاگین‌ها را دانلود می‌کند.
2. **Mason** سرورهای LSP را نصب می‌کند: `vtsls` (TS/JS)، `angularls`، `tailwindcss`، `html`، `cssls` و…
3. **Treesitter** پارسرهای هایلایت را کامپایل می‌کند.
4. بعد از اتمام، Neovim را ببندید و دوباره باز کنید.

### بررسی سلامت

داخل nvim این را بزنید:

```vim
:checkhealth
```

اگر همه‌چیز سبز یا فقط هشدارِ اختیاری بود، آماده‌اید.

## نصب دستی ابزارهای Mason (در صورت نیاز)

```vim
:Mason
```

باید این‌ها نصب باشند:

- `vtsls` — TypeScript/JavaScript (React, Next, Node, Express, Nest)
- `angularls` — انگولار (شامل قالب‌های HTML)
- `tailwindcss` — تکمیل کلاس‌های CSS
- `html` / `cssls` / `emmet_ls`
- `jsonls` / `yamlls` / `dockerls` / `bashls` / `pyright` / `lua_ls`
- `prettierd` / `eslint_d` / `stylua` — فرمتر و لینتر
- `js-debug-adapter` — دیباگر

## ترمینال پیشنهادی

برای تجربه کامل (مخصوصاً فارسی و Ctrl+Click):

- **kitty** یا **WezTerm** یا **iTerm2** — هر سه شکل‌دهی حروف فارسی و protocol موس را کامل پشتیبانی می‌کنند.
- Terminal.app ساده است و توصیه نمی‌شود.

## بعد از نصب

- فصل ۲ را بخوانید (مبانی Vim) — حتی اگر عجله دارید، ۲۰ دقیقه‌ای که آینده‌تان را نجات می‌دهد.
- `<Space>` را فشار دهید تا **which-key** منوی امکانات را نشان دهد — هیچ‌وقت لازم نیست کلیدها را حفظ کنید!
