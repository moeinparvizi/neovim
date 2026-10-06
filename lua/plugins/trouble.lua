-- trouble — WebStorm's Problems panel (diagnostics, references, TODOs)
return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Problems panel (buffer)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.workspace=true<CR>", desc = "Problems panel (project)" },
    { "<leader>xs", "<cmd>Trouble symbols toggle<CR>", desc = "Symbols (sidebar)" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "TODO / FIXME list" },
    { "[d", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous problem" },
    { "]d", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next problem" },
  },
}
