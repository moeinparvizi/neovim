# 📚 آموزش کامل — کانفیگ Neovim (نسخه Moein)

این پوشه، **آموزش کامل فارسی** کانفیگ Neovim شماست؛ از صفر تا سطح حرفه‌ای، هم‌تراز (و در خیلی جاها پرامکانات‌تر از) WebStorm.

> **مسیر پیشنهادی یادگیری:** اگر با Vim تازه شروع کردید، به ترتیبِ شماره‌ها جلو بروید. اگر کاربر قدیمی Vim هستید، مستقیم بروید سراغ فصل‌های ۶ به بعد که امکانات IDE را پوشش می‌دهند.

## فهرست فصل‌ها

| # | فصل | محتوا |
|---|------|--------|
| ۱ | [نصب و راه‌اندازی](01-installation.md) | پیش‌نیازها، نصب کانفیگ، بوت‌استرپ اولیه، حل مشکل اولیه |
| ۲ | [مبانی Vim](02-basics.md) | مفهوم Modal Editing، موشن‌ها، اپراتورها، تکس‌آبجکت، رجیسترها |
| ۳ | [مدیریت پنجره، بافر و تب](03-windows-buffers-tabs.md) | اسپلیت‌ها، جابجایی پنجره‌ها، تب‌بار، ترمینال‌ها |
| ۴ | [ادیتینگ حرفه‌ای](04-editing.md) | مولتی‌کرسر (Ctrl+Click)، Flash، اسنیپت‌ها، کامنت، سِراند، تغییر شکل کد |
| ۵ | [فایل و جستجو](05-file-navigation.md) | neo-tree، Telescope (جستجوی فایل و متن)، Spectre (جایگزینی در پروژه) |
| ۶ | [هوشمندی کد (LSP)](06-code-intelligence.md) | اتوکامپلیت، هاور، Rename (Shift+F6)، ریفکتور، کداکشن، Alt+Click |
| ۷ | [گیت کامل](07-git.md) | پول هوشمند (مثل Ctrl+T)، کانفلیکت‌ریزولوشن، استش، پوش، کامیت، blame، unversioned |
| ۸ | [هیستوری](08-history.md) | Undo Tree، Local History (عین WebStorm)، بازگشت به هر نقطه از زمان |
| ۹ | [اجرای پروژه و دیباگ](09-run-debug.md) | رانر npm، ترمینال شناور، دیباگر DAP (Next/Nest/Express/React) |
| ۱۰ | [تم و ظاهر](10-themes.md) | TokyoNight، انتخاب و ذخیره‌ی دائمی تم، UI |
| ۱۱ | [TODO و بوکمارک](11-todo-bookmarks.md) | لیست TODO/FIXME، مارک‌ها و بوکمارک‌ها |
| ۱۲ | [ساختار و فولدینگ](12-structure-folding.md) | پنل Structure، Breadcrumbs، فولدینگ مدرن (ufo) |
| ۱۳ | [پشتیبانی فارسی](13-persian.md) | تایپ فارسی با F9، نیم‌فاصله، فونت، RTL، نکات ترمینال |
| ۱۴ | [چیت‌شیت کلیدها](14-keymaps-cheatsheet.md) | جدول کامل تمام کلیدها (قابل پرینت!) |
| ۱۵ | [کاستومایز و توسعه](15-extend.md) | افزودن پلاگین، تم، زبان و مپینگ جدید |
| ۱۶ | [عیب‌یابی](16-troubleshooting.md) | مشکلات رایج و راه‌حل‌ها |

## جدول تطبیق WebStorm ↔ این کانفیگ

| امکانات WebStorm | معادل اینجا |
|---|---|
| Ctrl+T (Update Project) | `<leader>gp` پول هوشمند با autostash |
| Merge Dialog کانفلیکت | Diffview + `co/ct/cb` انتخاب طرف |
| Shift+F6 (Rename) | `<S-F6>` یا `<F2>` یا `<leader>cr` |
| Ctrl+Alt+Click | Alt+Click (رفتن به تعریف) |
| Alt+Click (افزودن کرسر) | Ctrl+Click (افزودن کرسر) |
| Local History | `<leader>hl` |
| Ctrl+Z / Undo History | `<leader>hu` (Undotree) |
| Double Shift | `<leader>ff` (فایل) / `<leader>fg` (متن) |
| Ctrl+Shift+F (Replace in Path) | `<leader>sr` (Spectre) |
| Structure Panel | `<leader>o` (Aerial) |
| TODO Panel | `<leader>xt` |
| Favorites / Bookmarks | `mm` / `m;` |
| Compare with Clipboard | `<leader>Dc` / `<leader>Ds` |
| Shelve/Unshelve | `<leader>gS` / `<leader>gs` |
| Run Configurations | `<leader>rr` / `<leader>rd` |
| Debug (F8/F7/F9) | `F5` / `F10` / `F11` |
| Terminal | `Ctrl+/` |
| Git Panel | `<leader>gg` (lazygit) |
| Theme Selector | `<leader>ut` |

> `<leader>` یعنی کلید **Space**. پس `<leader>gp` یعنی: `Space` بعد `g` بعد `p`.
