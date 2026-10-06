-- Moein's Neovim config — WebStorm-class IDE in the terminal
-- Repo: https://github.com/moeinparvizi/neovim
-- Docs: docs/ (فارسی)

-- Bootstrap everything
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- Load persisted colorscheme (see lua/config/theme.lua + <leader>ut)
require("config.theme").load()

-- Persian keyboard is available as :set keymap=persian — toggle with F9
-- (file: keymap/persian.vim, found automatically via runtimepath)
