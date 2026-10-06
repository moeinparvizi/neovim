-- aerial — the Structure tool window (file outline sidebar)
return {
  "stevearc/aerial.nvim",
  branch = "nvim-0.9", -- stable branch for nvim 0.9–0.11 (main requires 0.12)
  cmd = { "AerialToggle", "AerialNav" },
  keys = {
    { "<leader>o", "<cmd>AerialToggle right<CR>", desc = "Toggle structure (outline)" },
    { "<leader>co", "<cmd>AerialNavOpen<CR>", desc = "Structure navigator" },
  },
  opts = {
    layout = {
      default_direction = "right",
      width = 34,
      min_width = 28,
    },
    attach_mode = "window",
    backends = { "lsp", "treesitter", "markdown", "man" },
    show_guides = true,
    filter_kind = false, -- show variables too (like WebStorm)
    icons = {},
    nerd_font = "all",
  },
}
