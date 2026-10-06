-- Smart Git operations — the WebStorm-style workflow:
--  * smart pull  (<leader>gp): autostash + rebase pull; on conflict opens Diffview
--  * push        (<leader>gP)
--  * commit      (<leader>gc / <leader>gC)
--  * stash       (<leader>gs / <leader>gS)
local M = {}

local function git(args, cwd)
  cwd = cwd or vim.fn.getcwd()
  local obj = vim.system({ "git", "-C", cwd, unpack(args) }, { text = true }):wait()
  return obj.code == 0, (obj.stdout or "") .. (obj.stderr or "")
end

local function in_repo()
  local ok, _ = git({ "rev-parse", "--is-inside-work-tree" })
  return ok
end

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Git" })
end

local function root()
  local ok, out = git({ "rev-parse", "--show-toplevel" })
  if not ok then
    return vim.fn.getcwd()
  end
  return vim.trim(out)
end

---------------------------------------------------------------
-- SMART PULL — WebStorm "Update Project" (Ctrl+T):
-- stashes uncommitted changes, pulls with rebase, re-applies the stash;
-- if anything conflicts, opens Diffview's merge-tool to resolve.
---------------------------------------------------------------
function M.smart_pull()
  if not in_repo() then
    return notify("Not inside a git repository", vim.log.levels.WARN)
  end
  vim.cmd("silent! wall")

  notify("Pulling with autostash…")
  local ok, out = git({ "pull", "--rebase", "--autostash", "--stat" })

  if ok then
    notify("Update finished ✔\n" .. out:sub(1, 400))
    vim.cmd("checktime")
    -- refresh gitsigns if loaded
    pcall(function()
      require("gitsigns").refresh()
    end)
    return
  end

  -- Something went wrong — is it conflicts?
  local _, status = git({ "status", "--porcelain" })
  local conflicted = false
  for line in status:gmatch("[^\r\n]+") do
    if line:sub(1, 2):match("^(UU|AA|DD|AU|UA|DU|UD)") then
      conflicted = true
      break
    end
  end

  if conflicted then
    notify("Conflicts detected — opening Diffview.\nUse <leader>co / <leader>ct / <leader>cb to pick sides, then :Gcontinue", vim.log.levels.WARN)
    vim.cmd("DiffviewOpen")
  else
    notify("git pull failed:\n" .. out:sub(1, 600), vim.log.levels.ERROR)
  end
end

-- After resolving a smart-pull conflict
function M.rebase_continue()
  local ok, out = git({ "rebase", "--continue" })
  if ok then
    notify("Rebase continued ✔")
    vim.cmd("DiffviewClose")
  else
    notify(out:sub(1, 600), vim.log.levels.WARN)
  end
end

function M.rebase_abort()
  local ok, out = git({ "rebase", "--abort" })
  notify(ok and "Rebase aborted" or ("Abort failed:\n" .. out:sub(1, 400)), ok and vim.log.levels.INFO or vim.log.levels.WARN)
  pcall(vim.cmd.DiffviewClose)
end

---------------------------------------------------------------
-- Push
---------------------------------------------------------------
function M.push()
  if not in_repo() then
    return notify("Not inside a git repository", vim.log.levels.WARN)
  end
  notify("Pushing…")
  local ok, out = git({ "push" })
  if ok then
    notify("Pushed ✔")
  else
    -- no upstream yet → set it
    ok, out = git({ "push", "--set-upstream", "origin", "@", })
    notify(ok and "Pushed (upstream set) ✔" or ("Push failed:\n" .. out:sub(1, 600)), ok and vim.log.levels.INFO or vim.log.levels.ERROR)
  end
end

---------------------------------------------------------------
-- Commit with a message prompt (like WebStorm's commit dialog)
---------------------------------------------------------------
function M.commit(all)
  if not in_repo() then
    return notify("Not inside a git repository", vim.log.levels.WARN)
  end
  if all then
    git({ "add", "-A" })
  end
  local staged_ok, staged = git({ "diff", "--cached", "--stat" })
  if staged_ok and vim.trim(staged) == "" then
    return notify("Nothing staged to commit. Use <leader>gC to stage all, or stage in lazygit (<leader>gg).", vim.log.levels.WARN)
  end

  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if not msg or vim.trim(msg) == "" then
      return
    end
    local ok, out = git({ "commit", "-m", msg })
    if ok then
      notify("Committed ✔ " .. msg)
      pcall(function()
        require("gitsigns").refresh()
      end)
    else
      notify(out:sub(1, 600), vim.log.levels.ERROR)
    end
  end)
end

---------------------------------------------------------------
-- Stash / unstash  (WebStorm Shelve/Unshelve)
---------------------------------------------------------------
function M.stash_push()
  local msg = "nvim-stash " .. os.date("%Y-%m-%d %H:%M:%S")
  local ok, out = git({ "stash", "push", "--include-untracked", "-m", msg })
  notify(ok and ("Stashed ✔ " .. msg) or out:sub(1, 400), ok and vim.log.levels.INFO or vim.log.levels.ERROR)
  pcall(function()
    require("gitsigns").refresh()
  end)
end

function M.stash_pop()
  local ok, out = git({ "stash", "pop" })
  notify(ok and "Stash applied ✔" or out:sub(1, 400), ok and vim.log.levels.INFO or vim.log.levels.ERROR)
  pcall(function()
    require("gitsigns").refresh()
  end)
end

function M.root()
  return root()
end

return M
