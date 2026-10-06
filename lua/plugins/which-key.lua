-- which-key — popup cheat-sheet for every keybinding group
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = function(ctx)
      return ctx.plugin and 0 or 400
    end,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code / LSP" },
      { "<leader>d", group = "Debug (DAP)" },
      { "<leader>D", group = "Diff with clipboard" },
      { "<leader>f", group = "Find file…" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git hunk" },
      { "<leader>h", group = "History" },
      { "<leader>r", group = "Run project" },
      { "<leader>s", group = "Search" },
      { "<leader>u", group = "UI toggle" },
      { "<leader>w", group = "Window" },
      { "<leader>q", group = "Session / quit" },
    })
  end,
}
