-- Colorschemes — tokyonight is the default; <leader>ut opens the picker
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.NormalFloat = { bg = c.bg_dark }
        hl.FloatBorder = { bg = c.bg_dark, fg = c.border_highlight or c.blue }
      end,
    },
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 900, opts = { flavour = "macchiato" } },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 800, opts = {} },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 800, opts = {} },
  { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 800, opts = {} },
  { "navarasu/onedark.nvim", lazy = false, priority = 800, opts = {} },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 800, opts = {} },
}
