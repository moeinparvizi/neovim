-- Formatting (conform.nvim → prettierd) + linting (nvim-lint → eslint_d)
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = function(bufnr)
        -- skip if slow formatter unavailable
        local ok = pcall(require("conform").get_formatter_info, "prettierd", bufnr)
        return { timeout_ms = 800, lsp_format = "fallback", quiet = true }
      end,
      formatters_by_ft = {
        javascript = { "prettierd", stop_after_first = true },
        javascriptreact = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        typescriptreact = { "prettierd", stop_after_first = true },
        html = { "prettierd", stop_after_first = true },
        css = { "prettierd", stop_after_first = true },
        scss = { "prettierd", stop_after_first = true },
        json = { "prettierd", stop_after_first = true },
        jsonc = { "prettierd", stop_after_first = true },
        yaml = { "prettierd", stop_after_first = true },
        markdown = { "prettierd", stop_after_first = true },
        lua = { "stylua" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          pcall(lint.try_lint)
        end,
      })
    end,
  },
  -- Mason tools for the above (and DAP)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettierd",
        "eslint_d",
        "stylua",
        "js-debug-adapter",
      },
    },
  },
}
