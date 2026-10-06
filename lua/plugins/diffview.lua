-- Diffview — WebStorm-style git diff & merge-conflict resolution UI.
-- Smart-pull (<leader>gp) opens this automatically on conflicts.
-- Inside a conflict file: dx (take ours+), d2o (ours), d3o (theirs)…
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git status (diff view)" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
    { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
  },
  opts = {
    view = {
      merge_tool = {
        layout = "diff3",
        disable_diagnostics = true,
        winbar_info = true,
      },
    },
    file_panel = { win_config = { position = "left", width = 40 } },
    keymaps = {
      view = { ["q"] = "<cmd>DiffviewClose<CR>" },
      file_panel = { ["q"] = "<cmd>DiffviewClose<CR>" },
    },
    default_args = { DiffviewFileHistory = { "%" } },
  },
}
