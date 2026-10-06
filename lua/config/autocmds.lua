-- Autocommands
local augid = vim.api.nvim_create_augroup("moein-autocmds", { clear = true })

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augid,
  callback = function()
    vim.hl.on_yank({ timeout = 250 })
  end,
})

-- Return to last edit position when reopening a file (like IDEs)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augid,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Auto-create parent directories of a new file on first save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augid,
  callback = function(args)
    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(args.buf), ":p:h")
    if dir and dir ~= "" and vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Equalize window sizes when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augid,
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Local-history snapshot on every save (WebStorm Local History)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augid,
  callback = function(args)
    pcall(function()
      require("utils.local_history").snapshot(args.buf)
    end)
  end,
})

-- Close certain windows with just `q`
vim.api.nvim_create_autocmd("FileType", {
  group = augid,
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "oil", "dap-float" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

-- Terminal: start in insert mode and use Esc to leave
vim.api.nvim_create_autocmd("TermOpen", {
  group = augid,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
end,
})

-- Allow per-project config files (.nvim.lua) — Neovim prompts before trusting
vim.opt.exrc = true
