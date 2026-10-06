# فصل ۱۴ — چیت‌شیت کلیدها (قابل پرینت)

`<leader>` = کلید **Space**

## حرکت و پرش

| کلید | کار |
|---|---|
| `s` + ۲حرف | Flash jump |
| `S` | انتخاب Treesitter node |
| `gd` / `gi` / `gr` / `gy` | تعریف / پیاده‌سازی / رفرنس‌ها / نوع |
| **Alt+Click** | تعریف با ماوس |
| `%` | جفت پرانتز |
| `f/t` + حرف | در خط (؛ ، برای بعدی/قبلی) |
| `n` / `N` | نتایج جستجو |
| `g;` / `g,` | محل ویرایش قبلی/بعدی |
| `Ctrl+d/u` | نصف صفحه (وسط‌چین) |
| `zz` | خط جاری وسط صفحه |

## ادیت

| کلید | کار |
|---|---|
| `Ctrl+Click` | کرسر اضافه (مولتی‌کرسر) |
| `Ctrl+n` | کرسر روی تطبیق بعدی |
| `Ctrl+Up/Down` | کرسر بالا/پایین |
| `gcc` | کامنت خط |
| `gc` + موشن | کامنت محدوده |
| `sa/sd/sr` | surround افزودن/حذف/تعویض |
| `ci"`, `ci{`, `cit`, `dih` | تکس‌آبجکت‌ها |
| `J`/`K` (visual) | جابجایی انتخاب |
| `p` (visual) | پیست بدون خراب کردن رجیستر |
| `u` / `Ctrl+r` | undo / redo |
| `<S-F6>` / `F2` / `<leader>cr` | Rename هوشمند |
| `<leader>ca` | Quick fix (Alt+Enter) |
| `<leader>cA` | Source action (organize imports, fix all) |
| `<leader>cR` | Refactor |
| `<leader>cf` | فرمت فایل |
| `K` | مستندات (hover) |
| `ga` | align (visual) |

## فایل / جستجو / جایگزینی

| کلید | کار |
|---|---|
| `<leader>ff` / `fr` | فایل / اخیر |
| `<leader>fg` / `fw` | متن در پروژه / کلمه کرسر |
| `<leader>f/` | در فایل جاری |
| `<leader>sr` / `sw` | جایگزینی در پروژه / کلمه |
| `<leader>e` | اکپلورر |
| `<leader>fb` / `bb` | بافرها / بافر قبلی |
| `<S-h>` / `<S-l>` | بافر قبلی/بعدی |
| `<leader>1-9` | بافر شماره |

## پنجره / تب / ترمینال

| کلید | کار |
|---|---|
| `Ctrl+h/j/k/l` | بین پنجره‌ها |
| `<leader>wv` / `ws` | اسپلیت عمودی/افقی |
| `<leader>wq` / `wo` | بستن / بستن بقیه |
| `<leader>wH/J/K/L` | جابجایی پنجره |
| `Ctrl+Arrow` | تغییر اندازه |
| `<leader>w=` | هم‌اندازه |
| `Ctrl+/` | ترمینال شناور |
| `<leader>th` / `tv` / `ts` | ترمینال افقی/عمودی/انتخاب |

## گیت

| کلید | کار |
|---|---|
| `<leader>gp` | **پول هوشمند (Ctrl+T)** |
| `<leader>gP` | پوش |
| `<leader>gc` / `gC` | کامیت / همه+کامیت |
| `<leader>gS` / `gs` | stash / pop |
| `<leader>gg` | lazygit |
| `<leader>gd` / `gq` | Diffview باز/بسته |
| `<leader>gf` / `gF` | تاریخچه فایل / ریپو |
| `<leader>gu` / `ge` | changed+unversioned |
| `<leader>gb` / `ghb` | inline blame / blame خط |
| `]h` / `[h` | hunk بعدی/قبلی |
| `<leader>ghs` / `ghr` / `ghu` | stage / reset / undo-stage hunk |
| `<leader>ga` / `gr` | stage / reset کل فایل |
| `co` / `ct` / `cb` / `c0` | کانفلیکت: ours/theirs/both/none |
| `]x` / `[x` | کانفلیکت بعدی/قبلی |
| `:Gcontinue` / `:Gabort` | ادامه/لغو rebase |

## هیستوری / بوکمارک / TODO

| کلید | کار |
|---|---|
| `<leader>hl` | **Local History** (Enter: diff، Ctrl+r: restore) |
| `<leader>hu` / `hU` | undotree / undo telescope |
| `m` + حرف | بوکمارک |
| `'` + حرف | پرش |
| `m;` | لیست بوکمارک‌ها |
| `<leader>st` | TODO های پروژه |
| `<leader>xt` / `xx` / `xX` | TODO panel / خطاهای فایل / پروژه |

## اجرا / دیباگ

| کلید | کار |
|---|---|
| `<leader>rr` | انتخاب اسکریپت npm |
| `<leader>rd` | dev server |
| `<leader>rf` / `rs` | اجرای فایل / توقف |
| `<leader>db` / `dB` | breakpoint / شرطی |
| `F5` / `F10` / `F11` / `S-F11` | دیباگ: ادامه/over/into/out |
| `<leader>du` / `de` / `dr` | UI / eval / REPL |

## UI / تم / فارسی

| کلید | کار |
|---|---|
| `<leader>ut` | **انتخاب تم** (persist) |
| `<leader>ul` / `uL` / `uw` / `us` / `ui` / `ua` | اعداد نسبی/اعداد/wrap/spell/inlay/autosave |
| `F9` (insert) | **فارسی ↔ انگلیسی** |
| `Alt+Space` (insert) | نیم‌فاصله |
| `<leader>qS` / `qL` | ذخیره/بازیابی session |
| `<leader>?` | کلیدهای همین بافر |
| `Space` (توقف کوتاه) | منوی which-key |

## یونیکس‌مانندها

| دستور | کار |
|---|---|
| `:w` / `:wq` / `:q` | ذخیره / ذخیره+خروج / خروج |
| `:e file` | باز کردن |
| `:%s/a/b/g` | جایگزینی کل فایل (پیش‌نمایش زنده!) |
| `:noh` | پاک کردن هایلایت (یا Esc) |
| `:LocalHistory` | فصل ۸ |
| `:DiffClipboard` / `:'<,'>DiffSel` | مقایسه با کلیپ‌بورد |
| `:Gpull` / `:Gpush` | پول/پوش |
| `:PersianToggle` | سوییچ فارسی |
