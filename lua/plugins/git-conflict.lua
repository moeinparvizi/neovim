-- git-conflict — inline ours/theirs/both picker for merge conflicts.
-- While a pull/rebase conflicts: ]x/[x jump, <leader>co ours, <leader>ct theirs,
-- <leader>cb both, <leader>c0 none.
return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    default_mappings = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
    highlights = {
      incoming = "DiffAdd",
      current = "DiffChange",
    },
  },
}
