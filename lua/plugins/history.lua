-- History tools: undotree (visual undo tree) + telescope-undo
return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>hu", "<cmd>UndotreeToggle<CR>", desc = "Undo tree (local changes)" } },
    init = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    keys = { { "<leader>hU", "<cmd>Telescope undo<CR>", desc = "Undo history (telescope)" } },
  },
}
