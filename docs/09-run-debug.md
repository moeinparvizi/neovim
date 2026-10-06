# فصل ۹ — اجرای پروژه و دیباگ

## Run Configurations — رانر

| کلید | کار |
|---|---|
| `<leader>rr` | انتخاب اسکریپت npm از package.json (لیست کامل با توضیح) |
| `<leader>rd` | اجرای `dev` (اگر نبود `start`/`serve`) — یک کلید، سرور بالا |
| `<leader>rf` | اجرای فایل جاری (node/tsx/python/bash — بر اساس نوع فایل تشخیص می‌دهد) |
| `<leader>rs` | متوقف کردن رانر |

خروجی در **ترمینال شناور** می‌آید؛ `Esc` برای حرکت در ادیتور (ترمینال باز می‌ماند).

## ترمینال‌ها

| کلید | کار |
|---|---|
| `Ctrl+/` | ترمینال شناور toggle |
| `<leader>th` / `<leader>tv` | ترمینال افقی/عمودی |
| `<leader>ts` | سوییچ بین ترمینال‌ها |

هر پروژه ترمینال مخصوص خودش را دارد.

## دیباگر (DAP) — مثل وب‌استورم

| کلید | کار |
|---|---|
| `<leader>db` | breakpoint روی خط (دایره قرمز) |
| `<leader>dB` | breakpoint شرطی |
| `F5` | شروع دیباگ / ادامه |
| `F10` | step over |
| `F11` | step into |
| `S-F11` | step out |
| `<leader>dx` | توقف دیباگ |
| `<leader>du` | پنل‌های دیباگ (Variables/Watch/Stack) |
| `<leader>de` | evaluate عبارت زیر کرسر (در visual: انتخاب) |
| `<leader>dr` | REPL |

پنل‌ها خودکار موقع دیباگ باز می‌شوند: متغیرها، stack frames، breakpoints و پیش‌نمایش.

### سناریوهای آماده (Node/TS/Next/Express/Nest)

بعد از `F5` این گزینه‌ها را دارید:

1. **Launch current file** — اجرای فایل باز با inspect
2. **Attach to :9229** — وصل شدن به سرور در حال دیباگ (مثلاً `npm run dev` که با `--inspect` بالا آمده — Next/Nest همینطور)
3. **npm run dev (debug)** — خودش dev را با `--inspect-brk` بالا می‌آورد

> برای React در مرورگر: dev server را با `<leader>rd` بالا بیاورید، بعد attach کنید به پروسه node، یا دیباگ کروم را جدا اضافه کنید (فصل ۱۵).

## تست‌ها

فعلاً سریع‌ترین راه: `<leader>rr` → انتخاب `test`. (در نسخه‌های بعدی neotest اضافه می‌شود — فصل ۱۵)

بعدی: [فصل ۱۰ — تم و ظاهر](10-themes.md)
