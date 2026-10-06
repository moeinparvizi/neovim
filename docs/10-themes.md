# فصل ۱۰ — تم و ظاهر

## تم پیش‌فرض: TokyoNight

تم اصلی **tokyonight-night** است (همان تیره آبی-بنفش معروف). چهار واریانت دارد:

- `tokyonight-night` — تیره اصلی (پیش‌فرض)
- `tokyonight-moon` — تیره‌تر با رنگ‌های گرم‌تر
- `tokyonight-storm` — ملایم‌تر از night
- `tokyonight-day` — روشن

## انتخاب تم (persist می‌شود!)

| کلید | کار |
|---|---|
| `<leader>ut` | پنجره انتخاب تم با **پیش‌نمایش زنده** |

با فلش/`Ctrl+j/k` بین تم‌ها حرکت کنید — کل UI همان لحظه عوض می‌شود. `Enter` → تم انتخاب و **ذخیره می‌شود**؛ دفعه بعد که nvim باز کنید همان تم می‌آید. فایل ذخیره: `~/.local/state/nvim/colorscheme.txt`

تم‌های نصب‌شده: tokyonight (۴ واریانت)، catppuccin (macchiato/latte)، gruvbox، kanagawa، rose-pine، onedark، nightfox + هر تم دیگری که خودتان نصب کنید (فصل ۱۵).

## اجزای UI

| بخش | پلاگین | تنظیم |
|---|---|---|
| نوار تب‌ها | bufferline | با آیکون، شماره، diagnostic |
| نوار وضعیت | lualine | برنچ، تغییرات گیت، خطاها، وضعیت تایپ فارسی! |
| آیکون‌های gutter | gitsigns + diagnostic | |
| خطوط تورفتگی | indent-blankline | خط راهنما + هایلایت scope |
| نوتیفیکیشن‌ها | nvim-notify | گوشه پایین راست، تاریخچه: `<leader>sn` |
| صفحه شروع | dashboard | لوگو + میانبرهای سریع |
| breadcrumbs | dropbar | مسیر symbol ها بالای پنجره |

## ترفندهای ظاهری

| کلید | کار |
|---|---|
| `<leader>ul` | اعداد نسبی on/off |
| `<leader>uL` | اعداد on/off |
| `<leader>uw` | wrap (برای متن فارسی خوب است) |
| `<leader>us` | املایاب (spell) |
| `<leader>ui` | inlay hints |

بعدی: [فصل ۱۱ — TODO و بوکمارک](11-todo-bookmarks.md)
