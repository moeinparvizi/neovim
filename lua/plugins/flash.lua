-- flash.nvim — jump anywhere in the file with `s` (+ Treesitter select with S)
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = { multi_window = true },
    modes = {
      char = { enabled = true },
      search = { enabled = true }, -- enhanced `/` search
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash select Treesitter node" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote operator" },
  },
}
