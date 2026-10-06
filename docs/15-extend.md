# فصل ۱۵ — کاستومایز و توسعه

ساختار کانفیگ:

```
~/.config/nvim/
├── init.lua              # نقطه ورود
├── keymap/persian.vim    # چیدمان فارسی
├── lua/
│   ├── config/
│   │   ├── options.lua   # تنظیمات پایه
│   │   ├── keymaps.lua   # کلیدهای سراسری
│   │   ├── autocmds.lua  # رخدادها (ذخیره خودکار LocalHistory و...)
│   │   ├── theme.lua     # سیستم تم
│   │   └── lazy.lua      # بوت‌استرپ lazy.nvim
│   ├── utils/            # ماژول‌های اختصاصی (git, runner, local_history, ...)
│   └── plugins/          # هر پلاگین یک فایل
└── docs/                 # همین آموزش
```

## افزودن پلاگین جدید

فایل بسازید `lua/plugins/my-plugin.lua`:

```lua
return {
  "نام-کاربر/پلاگین",
  keys = {
    { "<leader>mz", function() print("hi") end, desc = "My thing" },
  },
  opts = {}, -- تنظیمات پلاگین
}
```

بعد: `:Lazy sync`. تمام — lazy.nvim خودش پیدا می‌کند (چون `import = "plugins"` است).

## افزودن کلید میانبر

اگر مال پلاگین خاصی نیست → `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>zz", "<cmd>Telescope oldfiles<CR>", { desc = "Recent" })
```

`desc` را حتماً بنویسید تا در which-key دیده شود.

## افزودن تم

```lua
-- lua/plugins/themes.lua یک خط اضافه کنید:
{ "نام-کاربر/تم", lazy = false, priority = 800, opts = {} },
```

بعد `<leader>ut` — خودش در لیست می‌آید و persist می‌شود.

## افزودن زبان جدید (مثلاً Go)

1. پارسر: به `ensure_installed` در `lua/plugins/treesitter.lua` اضافه کنید: `"go"`
2. سرور: به دو لیست در `lua/plugins/lsp.lua` اضافه کنید: `"gopls"` (هم در mason-lspconfig و هم در جدول `servers`)
3. فرمتر: در `lua/plugins/format-lint.lua`: `go = { "gofmt" }`
4. `:Lazy sync` و باز کردن nvim — Mason خودش نصب می‌کند

## تنظیمات مخصوص یک پروژه

در ریشه پروژه فایل `.nvim.lua` بسازید:

```lua
-- فقط همین پروژه
vim.opt.shiftwidth = 4
vim.b.my_flag = true
```

بار اول nvim می‌پرسد اعتماد می‌کنید؟ (`exrc` فعاله)

## تغییر دیباگر (مثلاً کروم برای React)

در `lua/plugins/dap.lua` اضافه کنید:

```lua
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
}
dap.configurations.javascriptreact = {
  { type = "chrome", request = "attach", name = "Attach Chrome", port = 9222, webRoot = "${workspaceFolder}" },
}
```

کروم را با `--remote-debugging-port=9222` باز کنید.

## به‌روزرسانی

- `:Lazy` → `U` (آپدیت همه پلاگین‌ها)
- `:Mason` → آپدیت سرورها
- `:TSUpdate` — آپدیت پارسرها
- کشیدن آخرین نسخه کانفیگ: `cd ~/.config/nvim && git pull`

بعدی: [فصل ۱۶ — عیب‌یابی](16-troubleshooting.md)
