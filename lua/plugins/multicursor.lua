-- multiple-cursors — Ctrl+Click adds a cursor, exactly like WebStorm.
-- Esc returns to normal mode; edits apply to every cursor.
return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",
  keys = {
    { "<C-LeftMouse>", "<cmd>MultipleCursorsMouse<CR>", mode = "n", desc = "Add cursor at mouse (Ctrl+Click)" },
    { "<C-Down>", "<cmd>MultipleCursorsAddDown<CR>", mode = "n", desc = "Add cursor below" },
    { "<C-Up>", "<cmd>MultipleCursorsAddUp<CR>", mode = "n", desc = "Add cursor above" },
    { "<C-n>", "<cmd>MultipleCursorsAddBySearch<CR>", mode = "n", desc = "Add cursor at next match" },
    { "<C-n>", "<cmd>MultipleCursorsAddBySearchCurrent<CR>", mode = "x", desc = "Add cursor at next match" },
  },
  opts = {},
}
