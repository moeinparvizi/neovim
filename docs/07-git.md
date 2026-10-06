# فصل ۷ — گیت کامل (قلب این کانفیگ)

این فصل مهم‌ترین تفاوت این کانفیگ با بقیه است: **چرخه کامل گیت بدون ترک ادیتور**، دقیقاً با عادت‌های WebStorm.

## نقشه کلی

| کار WebStorm | اینجا | توضیح |
|---|---|---|
| **Ctrl+T** (Update Project) | `<leader>gp` | **پول هوشمند** — پایین |
| Resolve Conflicts | خودکار با Diffview + `co/ct/cb` | پایین |
| Ctrl+K Commit | `<leader>gc` / `<leader>gC` | |
| Ctrl+Shift+K Push | `<leader>gP` | |
| Shelve / Unshelve | `<leader>gS` / `<leader>gs` | stash |
| Git tool window | `<leader>gg` (lazygit) یا `<leader>gd` (Diffview) | |
| Annotate/Blame | `<leader>gb` | |
| Show Diff | `<leader>gd` → انتخاب فایل | |
| Unversioned Files | `<leader>gu` یا `<leader>ge` | |
| Local History | `<leader>hl` (فصل ۸) | |

## پول هوشمند — همان Ctrl+T

وقتی `<leader>gp` می‌زنید:

1. همه تغییرات ذخیره می‌شوند
2. `git pull --rebase --autostash` اجرا می‌شود یعنی: تغییرات شما موقتاً **stash** می‌شوند → پول ربیس انجام می‌شود → تغییرات دوباره **برمی‌گردند**
3. اگر کانفلیخته: **نوتیفیکیشن + باز شدن خودکار Diffview** با پنل فایل‌های کانفلیکت‌دار
4. اگر سالمه: خلاصه آپدیت را می‌بینید، gitsigns هم رفرش می‌شود

این همان رفتاری است که وب‌استورم پیش‌فرض دارد (Update Project → Rebase + Clean working tree) — و همون چیزیه که خواستی: «فایل‌ها استش می‌شن و خودش از استش درمیاره که به کانفلیکت یا ارور نخوره».

## کانفلیکت‌ریزولوشن (دقیقاً عین Ctrl+T وب‌استورم)

وقتی کانفلیکت رخ داد، Diffview باز می‌شود:

1. پنل چپ = فایل‌های درگیر؛ `Tab` باز/بسته، `Enter` ورود به فایل
2. فایل کانفلیکت در **diff3** باز می‌شود: ours | پایه | theirs
3. داخل فایل (هر ادیتوری):

| کلید | کار |
|---|---|
| `]x` / `[x` | پرش به کانفلیکت بعدی/قبلی |
| **`co`** | فقط نسخه خودم (ours) |
| **`ct`** | فقط نسخه ریموت (theirs) |
| **`cb`** | هر دو (both) |
| `c0` | هیچ‌کدام |

4. بعد از حل همه: `:Gcontinue` (ادامه ربیس/مرج) یا `:Gabort` (لغو کل عملیات و برگشت به قبل پول)

## کامیت

| کلید | کار |
|---|---|
| `<leader>gc` | کامیت تغییرات staged (پنجره پیام باز می‌شود) |
| `<leader>gC` | اول همه (شامل untracked) stage می‌شود، بعد کامیت |
| `<leader>ga` | stage کل فایل جاری |
| `<leader>ghs` | stage فقط hunk (بخش تغییر) جاری / انتخابی |
| `<leader>ghu` | undo آخرین stage |

## پوش

| کلید | کار |
|---|---|
| `<leader>gP` | push (اگر upstream نبود خودش set می‌کند) |

## Stash — Shelve/Unshelve وب‌استورم

| کلید | کار |
|---|---|
| `<leader>gS` | stash (شامل فایل‌های untracked، با پیام زمان‌دار) |
| `<leader>gs` | برگرداندن آخرین stash و حذفش |

## lazygit — UI کامل گیت

`<leader>gg` → ترمینال شناور lazygit (واقعاً به آن نیاز پیدا می‌کنید برای history، cherry-pick، rebase تعاملی و...):

- `space` stage/unstage فایل یا hunk — **unversioned files هم اینجا نشان داده می‌شوند**
- `c` کامیت، `P` push، `p` pull
- `b` برنچ‌ها: `space` سوییچ، `n` برنچ جدید
- `enter` روی کامیت = diff، `s` squash، `r` reword
- `?` راهنما، `q` خروج

## دیدن تغییرات و تاریخچه

| کلید | کار |
|---|---|
| `<leader>gd` | Diffview: وضعیت کل پروژه + diff هر فایل |
| `<leader>gf` | تاریخچه فایل جاری (هر کامیت با diff) |
| `<leader>gF` | تاریخچه کل ریپو |
| `<leader>gb` | inline blame (معلق کردن نویسنده/تاریخ روی خط) |
| `<leader>ghb` | blame کامل خط جاری (پاپ‌آپ) |
| `<leader>gu` | لیست فایل‌های changed/unversioned (telescope) |
| `<leader>ge` | همان به شکل اکپلورر شناور |

## Gutter (کنار کد) — مثل نوار آبی/سبز وب‌استورم

- `▎` سبز = خط اضافه، نارنجی = تغییر، `▁` قرمز = حذف
- `]h` / `[h` = پرش بین تغییرات فایل
- `<leader>ghp` = پیش‌نمایش inline تغییر
- `<leader>ghr` = برگرداندن همان بخش (reset hunk)
- `ih` = انتخاب hunk به شکل text object (مثلاً `dih`)

## گردش‌کار روزمره پیشنهادی

```
صبح:            <leader>gp        (پول هوشمند)
کار می‌کنی...    (gitsigns کنار کد زنده است)
بخشی آماده شد:  <leader>ghs       (stage hunk)
                <leader>gc        (کامیت)
قبل از پوش:     <leader>gp        (یبار دیگه پول، اگر کانفلیخت حلش کن)
                <leader>gP        (پوش)
```

بعدی: [فصل ۸ — هیستوری](08-history.md)
