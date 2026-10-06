-- Global keymaps (plugin-specific keymaps live in each plugin spec)
local map = function(lhs, rhs, desc, mode)
  vim.keymap.set(mode or "n", lhs, rhs, { desc = desc, silent = true })
end

-----------------------------------------------------------
-- Persian input: F9 toggles the Persian keyboard inside insert mode
-----------------------------------------------------------
map("<F9>", "<C-^>", "Toggle Persian/English typing (insert)", { "i", "c" })
map("<M-Space>", "‌", "Insert نیم‌فاصله (ZWNJ)", "i")

-----------------------------------------------------------
-- Better defaults
-----------------------------------------------------------
map("<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "Q", "<nop>")
-- Move selected lines up/down (like WebStorm Shift+Cmd+Up/Down)
map("J", ":m '>+1<CR>gv=gv", "Move selection down", "v")
map("K", ":m '<-2<CR>gv=gv", "Move selection up", "v")
-- Keep the yanked word when pasting over a selection
map("p", '"_dp', "Paste without yanking selection", "x")
map("P", '"_dP', "Paste (before) without yanking", "x")

-----------------------------------------------------------
-- Window management  (docs/03-windows-buffers-tabs.md)
-----------------------------------------------------------
map("<C-h>", "<C-w>h", "Go to left window")
map("<C-j>", "<C-w>j", "Go to below window")
map("<C-k>", "<C-w>k", "Go to above window")
map("<C-l>", "<C-w>l", "Go to right window")
map("<C-Up>", "<cmd>resize +2<CR>", "Increase window height")
map("<C-Down>", "<cmd>resize -2<CR>", "Decrease window height")
map("<C-Left>", "<cmd>vertical resize -2<CR>", "Decrease window width")
map("<C-Right>", "<cmd>vertical resize +2<CR>", "Increase window width")
map("<leader>wv", "<C-w>v", "Split window vertically")
map("<leader>ws", "<C-w>s", "Split window horizontally")
map("<leader>wq", "<C-w>c", "Close window")
map("<leader>wo", "<C-w>o", "Close other windows")
map("<leader>wh", "<C-w>H", "Move window to far left")
map("<leader>wj", "<C-w>J", "Move window to far bottom")
map("<leader>wk", "<C-w>K", "Move window to far top")
map("<leader>wl", "<C-w>L", "Move window to far right")
map("<leader>w=", "<C-w>=", "Equalize window sizes")
map("<leader>ww", "<C-w>w", "Cycle windows")

-- Terminal-mode navigation
map("<C-h>", "<C-\\><C-n><C-w>h", "Terminal: go left", "t")
map("<C-j>", "<C-\\><C-n><C-w>j", "Terminal: go down", "t")
map("<C-k>", "<C-\\><C-n><C-w>k", "Terminal: go up", "t")
map("<C-l>", "<C-\\><C-n><C-w>l", "Terminal: go right", "t")

-----------------------------------------------------------
-- Buffers / tabs (bufferline covers the tab bar)
-----------------------------------------------------------
map("<S-h>", "<cmd>bprevious<CR>", "Previous buffer")
map("<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("<leader>bd", function()
  require("utils.buf").delete_safe()
end, "Delete buffer")
map("<leader>bo", "<cmd>%bd|e#|bd#<CR>", "Close other buffers")
for i = 1, 9 do
  map("<leader>" .. i, ":" .. i .. "b<CR>", "Go to buffer " .. i)
end

-----------------------------------------------------------
-- Alt+Click → go to definition (like WebStorm Cmd+Click)
-- Ctrl+Click → add another cursor (multiple-cursors.nvim)
-----------------------------------------------------------
vim.keymap.set("n", "<M-LeftMouse>", function()
  local pos = vim.fn.getmousepos()
  if pos and pos.winid == vim.api.nvim_get_current_win() then
    vim.api.nvim_win_set_cursor(0, { pos.line, math.max(pos.column - 1, 0) })
    vim.lsp.buf.definition()
  end
end, { desc = "Alt+Click: go to definition" })

vim.keymap.set("n", "<M-LeftRelease>", "<LeftRelease>", { desc = "Alt release" })

-----------------------------------------------------------
-- Quickfix / location lists
-----------------------------------------------------------
map("[q", "<cmd>cprev<CR>", "Previous quickfix item")
map("]q", "<cmd>cnext<CR>", "Next quickfix item")

-----------------------------------------------------------
-- Toggle group: <leader>u
-----------------------------------------------------------
map("<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, "Toggle line wrap")
map("<leader>us", function()
  vim.opt.spell = not vim.opt.spell:get()
end, "Toggle spell check")
map("<leader>ul", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, "Toggle relative numbers")
map("<leader>uL", function()
  vim.opt.number = not vim.opt.number:get()
end, "Toggle line numbers")
