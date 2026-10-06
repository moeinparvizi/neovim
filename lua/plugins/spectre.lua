-- spectre — project-wide find & replace (WebStorm Replace in Path)
return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Replace in project" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Replace word in project" },
  },
  opts = { is_insert_mode = true },
}
