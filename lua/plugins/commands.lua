-- Wires custom utilities (git/runner/diff/persian/history) into keymaps & commands.
-- This is the "WebStorm shortcuts" layer — see docs/14-keymaps-cheatsheet.md
return {
  "nvim-lua/plenary.nvim",
  lazy = false,
  config = function()
    -------------------------------------------------------------
    -- Git (WebStorm: Ctrl+T update, Ctrl+K commit, push, shelve)
    -------------------------------------------------------------
    vim.keymap.set("n", "<leader>gp", function() require("utils.git").smart_pull() end, { desc = "Smart pull (autostash)" })
    vim.keymap.set("n", "<leader>gP", function() require("utils.git").push() end, { desc = "Push" })
    vim.keymap.set("n", "<leader>gc", function() require("utils.git").commit(false) end, { desc = "Commit staged…" })
    vim.keymap.set("n", "<leader>gC", function() require("utils.git").commit(true) end, { desc = "Stage all + commit…" })
    vim.keymap.set("n", "<leader>gS", function() require("utils.git").stash_push() end, { desc = "Stash (shelve)" })
    vim.keymap.set("n", "<leader>gs", function() require("utils.git").stash_pop() end, { desc = "Stash pop (unshelve)" })
    vim.api.nvim_create_user_command("Gcontinue", function() require("utils.git").rebase_continue() end, { desc = "Continue rebase after conflict resolution" })
    vim.api.nvim_create_user_command("Gabort", function() require("utils.git").rebase_abort() end, { desc = "Abort a conflicted rebase" })
    vim.api.nvim_create_user_command("Gpull", function() require("utils.git").smart_pull() end, { desc = "Smart pull" })
    vim.api.nvim_create_user_command("Gpush", function() require("utils.git").push() end, { desc = "Push" })

    -------------------------------------------------------------
    -- Compare with clipboard
    -------------------------------------------------------------
    vim.keymap.set("n", "<leader>Dc", function() require("utils.clipboard_diff").compare_file() end, { desc = "Diff file ↔ clipboard" })
    vim.keymap.set("x", "<leader>Ds", function() require("utils.clipboard_diff").compare_selection() end, { desc = "Diff selection ↔ clipboard" })

    -------------------------------------------------------------
    -- Project runner
    -------------------------------------------------------------
    vim.keymap.set("n", "<leader>rr", function() require("utils.runner").pick_script() end, { desc = "Run npm script…" })
    vim.keymap.set("n", "<leader>rd", function() require("utils.runner").run_dev() end, { desc = "Run dev server" })
    vim.keymap.set("n", "<leader>rf", function() require("utils.runner").run_file() end, { desc = "Run current file" })
    vim.keymap.set("n", "<leader>rs", function() require("utils.runner").stop() end, { desc = "Stop runner" })

    -------------------------------------------------------------
    -- Local history & undo
    -------------------------------------------------------------
    vim.keymap.set("n", "<leader>hl", function() require("utils.local_history").browse() end, { desc = "Local history browser" })

    -------------------------------------------------------------
    -- Persian input control
    -------------------------------------------------------------
    vim.api.nvim_create_user_command("PersianOn", function()
      vim.opt.keymap = "persian"
      vim.bo.iminsert = 1
    end, { desc = "فعال‌سازی تایپ فارسی" })
    vim.api.nvim_create_user_command("PersianOff", function()
      vim.bo.iminsert = 0
    end, { desc = "بازگشت به تایپ انگلیسی" })
    vim.api.nvim_create_user_command("PersianToggle", function()
      if vim.bo.iminsert == 1 then
        vim.bo.iminsert = 0
      else
        vim.opt.keymap = "persian"
        vim.bo.iminsert = 1
      end
    end, { desc = "تغییر فارسی/انگلیسی" })

    -------------------------------------------------------------
    -- UI toggles that need libraries
    -------------------------------------------------------------
    vim.keymap.set("n", "<leader>ui", function()
      if vim.lsp.inlay_hint then
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
        vim.notify("Inlay hints: " .. (enabled and "off" or "on"))
      end
    end, { desc = "Toggle inlay hints" })

    -- Auto-save & auto-format toggles
    local autosave = vim.api.nvim_create_augroup("autosave", { clear = false })
    vim.keymap.set("n", "<leader>ua", function()
      if vim.fn.exists("#autosave#InsertLeave") == 1 then
        vim.api.nvim_clear_autocmds({ group = autosave })
        vim.notify("Auto-save off")
      else
        vim.api.nvim_create_autocmd("InsertLeave", {
          group = autosave,
          callback = function()
            if vim.bo.modified and vim.bo.buftype == "" then
              vim.cmd("silent! write")
            end
          end,
        })
        vim.notify("Auto-save on")
      end
    end, { desc = "Toggle auto-save" })
  end,
}
