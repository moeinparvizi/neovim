-- Small buffer helpers
local M = {}

-- Delete buffer without destroying the window layout
function M.delete_safe()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    local choice = vim.fn.confirm("Buffer is modified. Save changes?", "&Save\n&Discard\n&Cancel")
    if choice == 1 then
      vim.cmd("write")
    elseif choice ~= 2 then
      return
    end
  end
  -- If it's the only buffer, open a dashboard; otherwise just wipe
  if vim.fn.winnr("$") == 1 and vim.fn.bufnr("$") == 1 then
    vim.cmd("enew | bdelete " .. buf)
  else
    vim.cmd("bprevious | bdelete " .. buf)
  end
end

return M
