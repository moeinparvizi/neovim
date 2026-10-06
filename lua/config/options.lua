-- General Neovim options (behavior shared with every plugin)
local opt = vim.opt

-- Leader keys (must be set before lazy.nvim boots)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false -- lualine/bufferline already show it
opt.pumheight = 14
opt.laststatus = 3 -- one global statusline
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true -- when wrap is on, break at spaces (good for Persian prose)
opt.breakindent = true

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live :s preview
opt.splitbelow = true
opt.splitright = true
opt.autoread = true
opt.mouse = "a" -- enables Ctrl+Click / Alt+Click features
opt.clipboard = "unnamedplus" -- system clipboard like WebStorm

-- Persistent undo (per-file undo history across restarts)
opt.undofile = true
opt.undodir:append(vim.fn.stdpath("state") .. "/undo")

-- Sessions / swap
opt.swapfile = false
opt.writebackup = false

-- Folding (nvim-ufo enhances these)
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Persian / RTL-friendly text handling
-- (nvim joins Arabic-script letters itself; terminals like kitty/iTerm2/WezTerm
--  render them correctly. Paragraph direction stays LTR — see docs/13-persian.md)
vim.cmd([[ set delcombine ]])

-- Search
opt.hlsearch = true

-- Don't continue comments with o/O automatically
opt.formatoptions:remove({ "o" })

-- netrw is replaced by neo-tree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
