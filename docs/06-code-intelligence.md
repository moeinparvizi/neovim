# فصل ۶ — هوشمندی کد (LSP)

LSP یعنی Language Server Protocol — همون موتوری که WebStorm هم (به شکل خودش) استفاده می‌کند. این کانفیگ برای دنیای JS/TS از **vtsls** (قوی‌ترین سرور TypeScript) و **angularls** استفاده می‌کند.

## پشتیبانی زبان‌ها

| زبان/فریمورک | سرور | نکته |
|---|---|---|
| TypeScript / JavaScript / React / Next | vtsls | اتوکامپلیت + هایلایت + ریفکتور |
| **Angular** | angularls | شامل قالب‌های HTML — rename کامپوننت در template ها هم اعمال می‌شود |
| Node / Express / Nest | vtsls | NestJS هم TS است؛ decorator ها پشتیبانی می‌شوند |
| Tailwind CSS | tailwindcss | تکمیل کلاس + رنگ پیش‌نمایش |
| HTML / CSS / SCSS | html, cssls | + emmet |
| JSON / YAML | jsonls, yamlls | با اسکیمای package.json و k8s و… |
| Python | pyright | |
| Lua / Bash / Docker | lua_ls, bashls, dockerls | |

## اتوکامپلیت (blink.cmp)

همین‌طور که تایپ می‌کنید ظاهر می‌شود؛ پنجره مستندات هم کنارش باز است (مثل وب‌استورم).

| کلید | کار |
|---|---|
| `Tab` / `S-Tab` | انتخاب بعدی/قبلی (همراه اسنیپت‌ها) |
| `Enter` | پذیرش |
| `Ctrl+Space` | باز کردن اجباری/رفرش |
| `Ctrl+b/f` | اسکرول مستندات |
| ghost text | پیشنهاد AI-مانند خاکستری؛ `Tab` می‌پذیرید |

اسنیپت‌های friendly-snippets هم فعاله (مثلاً `nfn` در TS).

## هاور و مستندات (Ctrl+Q وب‌استورم)

| کلید | کار |
|---|---|
| `K` | مستندات symbol زیر کرسر (پنجره border دار) |
| `<C-w>d` | تعریف در پنجره جدا |
| `<leader>cd` | نمایش خطای/هشدار همان خط |

## پرش‌ها (WebStorm: Ctrl+B / Ctrl+Alt+B / Alt+Click)

| کلید | کار |
|---|---|
| **Alt+Click** | پرش به تعریف با ماوس (عین نگه‌داشتن Ctrl و کلیک در وب‌استورم!) |
| `gd` | تعریف (لیست fuzzy) |
| `gi` | implementation (پیاده‌سازی interface) |
| `gr` | همه references (کاربردها) |
| `gy` | type definition |
| `gD` | declaration |

## Rename — Shift+F6 وب‌استورم

| کلید | کار |
|---|---|
| `<S-F6>` / `F2` / `<leader>cr` | rename هوشمند symbol |

چرا LSP rename بهتر از مولتی‌کرسر است؟ چون **کاربردها را از import ها، قالب‌های انگولار و رفرنس‌های دیگر فایل‌ها هم پیدا می‌کند**. import ها هم خودکار آپدیت می‌شوند (`updateImportsOnFileMove` فعاله — جابجایی فایل = آپدیت مسیر import).

## Code Actions — Alt+Enter وب‌استورم

| کلید | کار |
|---|---|
| `<leader>ca` | quick-fix های همان نقطه (اضافه کردن import، ساخت متد، ...) |
| `<leader>cA` | source actions: organize imports، fix-all و... |
| `<leader>cR` | ریفکتورها (extract function/variable/constant و...) |

همین کار در وب‌استورم Alt+Enter بود. منوی code action هم با `Ctrl+j/k` حرکت کنید.

## ریفکتور

- **Extract**: `<leader>cR` → انتخاب refactor های سرور (Extract to function/constant، Convert to async و...)
- **Rename**: `<S-F6>`
- **Move/آپدیت import**: جابجایی فایل در neo-tree با `a` (rename) — مسیرها خودکار اصلاح می‌شوند
- **Surround/align/…**: فصل ۴

## فرمت خودکار و ESLint

- ذخیره = فرمت با prettierd (اگر پروژه .prettierrc دارد از همان پیروی می‌کند)
- organize imports هم خودکار موقع ذخیره (vtsls)
- eslint_d خروجی‌اش در gutter و پنل Problems می‌آید

## Problems panel (وب‌استورم: Alt+6)

| کلید | کار |
|---|---|
| `<leader>xX` | پنل خطاهای کل پروژه |
| `<leader>xx` | فقط فایل جاری |
| `]d` / `[d` | خطای بعدی/قبلی |
| `<leader>ui` | نمایش/مخفی inlay hints (نوع‌ها و نام پارامترها داخل کد) |

بعدی: [فصل ۷ — گیت کامل](07-git.md)
