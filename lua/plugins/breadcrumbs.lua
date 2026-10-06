-- dropbar — clickable breadcrumbs (winbar) like WebStorm's path bar
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Breadcrumbs: pick symbol" },
  },
  opts = {
    menu = { win_configs = { border = "rounded" } },
    sources = {
      path = { relative_to = function() return vim.fn.getcwd() end },
    },
  },
}
