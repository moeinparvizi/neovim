-- neo-tree — file explorer with git status (incl. unversioned files)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<CR>", desc = "File explorer" },
    { "<leader>ge", "<cmd>Neotree float git_status<CR>", desc = "Git status explorer" },
    { "<leader>be", "<cmd>Neotree float buffers<CR>", desc = "Buffers explorer" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    default_source = "filesystem",
    sources = { "filesystem", "buffers", "git_status" },
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_pattern = { "node_modules" },
      },
    },
    git_status = {
      window = { position = "float" },
      symbols = {
        -- matches WebStorm colors: green=staged, amber=modified, gray=unversioned
        added = "✚",
        modified = "",
        deleted = "✖",
        renamed = "󰁕",
        untracked = "",
        ignored = "󰘓",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
    window = {
      width = 32,
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["P"] = "toggle_preview",
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
