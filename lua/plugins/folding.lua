-- nvim-ufo — modern, LSP/Treesitter-aware code folding (zR / zM / za)
return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- folding setup happens in options.lua (foldlevel=99 → all open by default)
  end,
  config = function()
    local ufo = require("ufo")
    ufo.setup({
      provider_selector = function(_, _, _)
        return { "lsp", "indent" }
      end,
      open_fold_hl_timeout = 150,
      preview = {
        win_config = { border = "rounded" },
      },
    })
    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Fold more open" })
    vim.keymap.set("n", "zm", function()
      require("ufo").closeFoldsWith(0)
    end, { desc = "Fold less open" })
  end,
}
