-- lualine — statusline with git branch, diagnostics, Persian-input indicator
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = { modified = "●", readonly = "󰌾", unnamed = "[بدون نام]" },
        },
      },
      lualine_x = {
        {
          function()
            if vim.bo.iminsert == 1 and vim.bo.keymap ~= "" then
              return "فارسی"
            end
            return ""
          end,
          color = { fg = "#ff9e64", gui = "bold" },
          separator = "",
        },
        { "diagnostics" },
        { "filetype" },
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
