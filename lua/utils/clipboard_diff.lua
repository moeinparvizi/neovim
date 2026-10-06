-- Compare with clipboard — WebStorm's "Compare with Clipboard"
--   :DiffClipboard  /  <leader>Dc   → diff whole file against the clipboard
--   :'<,'>DiffSel   /  <leader>Ds   → diff the selection against the clipboard
local M = {}

local counter = 0

local function scratch_buf(name, lines)
  counter = counter + 1
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, ("%s [%d]"):format(name, counter))
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  return buf
end

local function open_diff(name_left, left, name_right, right)
  vim.cmd("tabnew")
  local b1 = scratch_buf(name_left, left)
  vim.api.nvim_set_current_buf(b1)
  vim.cmd("vnew")
  local b2 = scratch_buf(name_right, right)
  vim.api.nvim_set_current_buf(b2)
  vim.cmd("windo diffthis")
  vim.notify("Diff view — use ]c / [c to jump between differences, `tabnew` closed with `:q`", vim.log.levels.INFO, { title = "Compare with clipboard" })
end

function M.compare_file()
  local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  if fname == "" then
    fname = "untitled"
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local clip = vim.fn.getreg("+"):gsub("\r\n", "\n")
  open_diff(fname .. " (file)", lines, fname .. " (clipboard)", vim.split(clip, "\n", { plain = true }))
end

function M.compare_selection()
  local start_mark = vim.api.nvim_buf_get_mark(0, "<")
  local end_mark = vim.api.nvim_buf_get_mark(0, ">")
  if not start_mark or not end_mark then
    return
  end
  local lines = vim.api.nvim_buf_get_lines(0, start_mark[1] - 1, end_mark[1], false)
  local clip = vim.fn.getreg("+"):gsub("\r\n", "\n")
  open_diff("selection (file)", lines, "selection (clipboard)", vim.split(clip, "\n", { plain = true }))
end

vim.api.nvim_create_user_command("DiffClipboard", M.compare_file, { desc = "Diff current file with clipboard" })
vim.api.nvim_create_user_command("DiffSel", M.compare_selection, { range = true, desc = "Diff selection with clipboard" })

return M
