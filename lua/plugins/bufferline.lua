-- bufferline — WebStorm-style editor tabs
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin/unpin buffer" },
    { "<leader>bP", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      separator_style = "thin",
      offsets = {
        {
          filetype = "neo-tree",
          text = "  Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
