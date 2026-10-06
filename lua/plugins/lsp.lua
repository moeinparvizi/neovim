-- LSP: Mason (server installer) + nvim-lspconfig (new vim.lsp.config API)
-- Angular / React / Next / Node / Express / Nest support via vtsls + angularls.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "vtsls", -- TypeScript/JavaScript: React, Next, Node, Express, Nest
          "angularls", -- Angular (also renames inside .html templates!)
          "tailwindcss", -- class autocomplete + sorting
          "html",
          "cssls",
          "emmet_ls",
          "jsonls",
          "yamlls",
          "dockerls",
          "docker_compose",
          "bashls",
          "pyright",
          "lua_ls",
        },
        automatic_enable = {
          exclude = { "ts_ls" }, -- vtsls is the TS server; no duplicates
        },
      },
    },
    "b0o/schemastore.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local capabilities = {}
    pcall(function()
      capabilities = require("blink.cmp").get_lsp_capabilities()
    end)

    local on_attach = function(client, bufnr)
      -- Inlay hints (parameter names etc.) — toggle with <leader>ui
      if vim.lsp.inlay_hint then
        pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
      end

      -- Organize imports on save for TS/JS (executes through the vtsls client
      -- so its extension commands like _typescript.didOrganizeImports resolve)
      if client.name == "vtsls" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
            params.context = { only = { "source.organizeImports" }, diagnostics = {} }
            client:request("textDocument/codeAction", params, function(err, res)
              if err or not res then
                return
              end
              for _, action in ipairs(res) do
                if action.edit then
                  vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                elseif type(action.command) == "table" then
                  pcall(client.exec_cmd, client, action.command, { bufnr = bufnr })
                end
              end
            end, bufnr)
          end,
        })
      end

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
      end
      map("gd", "<cmd>Telescope lsp_definitions<CR>", "Go to definition")
      map("gD", vim.lsp.buf.declaration, "Go to declaration")
      map("gi", "<cmd>Telescope lsp_implementations<CR>", "Go to implementation")
      map("gr", "<cmd>Telescope lsp_references<CR>", "Find references")
      map("gy", "<cmd>Telescope lsp_type_definitions<CR>", "Go to type definition")
      map("K", vim.lsp.buf.hover, "Hover documentation")
      map("<C-w>d", vim.lsp.buf.definition, "Definition (split)")
      map("<leader>cr", vim.lsp.buf.rename, "Rename symbol (Shift+F6)")
      map("<F2>", vim.lsp.buf.rename, "Rename symbol")
      map("<S-F6>", vim.lsp.buf.rename, "Rename symbol")
      map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
      map("<leader>cA", function()
        vim.lsp.buf.code_action({ context = { only = { "source" } }, apply = true })
      end, "Source actions (fix all, organize imports…)")
      map("<leader>cR", function()
        vim.lsp.buf.code_action({ context = { only = { "refactor" } } })
      end, "Refactor this…")
      map("<leader>cf", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, "Format file")
      map("<leader>cl", "<cmd>LspInfo<CR>", "LSP info")
      map("[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, "Previous diagnostic")
      map("]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, "Next diagnostic")
      map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
    end

    -- Global diagnostic look
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
    })

    -- Rounded borders for LSP floats
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    local servers = {
      "vtsls",
      "angularls",
      "tailwindcss",
      "html",
      "cssls",
      "emmet_ls",
      "jsonls",
      "yamlls",
      "dockerls",
      "docker_compose",
      "bashls",
      "pyright",
    }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    -- Server-specific settings
    vim.lsp.config("vtsls", {
      settings = {
        javascript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = false },
            enumMemberValues = { enabled = true },
          },
          updateImportsOnFileMove = { enabled = "always" },
          preferences = { importModuleSpecifierPreference = "non-relative" },
        },
        typescript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = false },
            enumMemberValues = { enabled = true },
          },
          updateImportsOnFileMove = { enabled = "always" },
          preferences = { importModuleSpecifierPreference = "non-relative" },
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = true, url = "" },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })

    vim.lsp.config("lua_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          completion = { callSnippet = "Replace" },
          hint = { enable = true },
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    vim.lsp.config("emmet_ls", {
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "angular",
      },
    })
  end,
}
