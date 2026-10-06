-- Session restore + dashboard + notifications + indent guides
return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save session" },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      config = {
        header = {
          "███╗   ██╗ ██████╗ ███████╗██╗██╗   ██╗███████╗",
          "████╗  ██║██╔═══██╗██╔════╝██║██║   ██║██╔════╝",
          "██╔██╗ ██║██║   ██║█████╗  ██║██║   ██║█████╗  ",
          "██║╚██╗██║██║   ██║██╔══╝  ██║╚██╗ ██╔╝██╔══╝  ",
          "██║ ╚████║╚██████╔╝██║     ██║ ╚████╔╝ ███████╗",
          "╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝  ╚═══╝  ╚══════╝",
          "              [ Moein's IDE · Neovim ]",
        },
        shortcut = {
          { desc = " Find file", group = "Label", action = "Telescope find_files", key = "f" },
          { desc = " Recent", group = "Label", action = "Telescope oldfiles", key = "r" },
          { desc = " Git (lazygit)", group = "Label", action = "lua require('utils.term').lazygit()", key = "g" },
          { desc = " Restore session", group = "Label", action = "lua require('persistence').load()", key = "s" },
          { desc = " Explorer", group = "Label", action = "Neotree toggle left", key = "e" },
        },
        footer = { "docs/ ← آموزش فارسی" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = { timeout = 2500, max_width = 60, stages = "fade_in_slide_out" },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },
}
