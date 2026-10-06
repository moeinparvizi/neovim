-- blink.cmp — fast autocomplete with documentation window + signature help
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp" ,
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  opts = {
    snippets = { preset = "luasnip" },
    appearance = {
      nerd_font_variant = "normal",
      kind_icons = {
        Text = " ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = "󰂧 ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = " ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = " ",
      },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
        },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
