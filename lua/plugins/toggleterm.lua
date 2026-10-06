-- toggleterm — floating/horizontal terminals + lazygit UI (<leader>gg)
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermSelect", "LazyGit" },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", desc = "Vertical terminal" },
    { "<leader>ts", "<cmd>TermSelect<CR>", desc = "Select terminal" },
    {
      "<leader>gg",
      function()
        require("utils.term").lazygit()
      end,
      desc = "lazygit (full git UI)",
    },
  },
  opts = {
    open_mapping = false,
    direction = "float",
    float_opts = { border = "rounded" },
    highlights = { NormalFloat = { link = "Normal" }, FloatBorder = { link = "Comment" } },
  },
}
