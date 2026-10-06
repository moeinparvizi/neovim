-- gitsigns — git gutter, stage/revert hunks, inline blame
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "]h", function() require("gitsigns").next_hunk() end, desc = "Next git hunk" },
    { "[h", function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" },
    { "<leader>ghs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
    { "<leader>ghr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
    { "<leader>ghp", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview hunk inline" },
    { "<leader>ghb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line (full)" },
    { "<leader>gS", false },
    { "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" },
    { "<leader>ga", function() require("gitsigns").stage_buffer() end, desc = "Stage whole buffer" },
    { "<leader>gr", function() require("gitsigns").reset_buffer() end, desc = "Reset whole buffer" },
    { "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle inline blame" },
    { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Diff buffer vs HEAD" },
    { "<leader>ghs", function() require("gitsigns").stage_hunk() end, mode = "v", desc = "Stage selection" },
    { "<leader>ghr", function() require("gitsigns").reset_hunk() end, mode = "v", desc = "Reset selection" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged_enable = true,
    current_line_blame = false,
    current_line_blame_opts = { delay = 300, virt_text_pos = "eol" },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      vim.keymap.set("o", "ih", function()
        vim.cmd("normal! v")
        gs.select_hunk()
      end, { buffer = bufnr, desc = "inner hunk text object" })
      vim.keymap.set("x", "ih", function()
        gs.select_hunk()
      end, { buffer = bufnr, desc = "inner hunk text object" })
    end,
  },
}
