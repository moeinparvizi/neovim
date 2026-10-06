-- Editing helpers: auto-pairs, auto-close/rename HTML & JSX tags, mini.align
return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}, -- enables close + rename matching tags (HTML/JSX/Angular)
  },
  {
    "echasnovski/mini.align",
    version = false,
    event = "VeryLazy",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align interactively" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    keys = {
      { "sa", desc = "Add surrounding", mode = { "n", "v" } },
      { "sd", desc = "Delete surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sh", desc = "Highlight surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
    },
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        replace = "sr",
        highlight = "sh",
        find = "sf",
        find_left = "sF",
        update_n_lines = "sn",
      },
    },
  },
}
