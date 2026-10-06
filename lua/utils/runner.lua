-- Project runner — WebStorm's Run Configurations, terminal edition.
--   <leader>rr  pick an npm script from package.json (dev/start/serve/build/test…)
--   <leader>rd  run the "dev" script (falls back to start/serve)
--   <leader>rf  run the current file (node / tsx / python / sh)
--   <leader>rs  stop the runner
local M = {}
local runner_term = nil

local function project_root()
  local cwd = vim.fn.getcwd()
  local dir = cwd
  for _ = 1, 20 do
    if vim.fn.filereadable(dir .. "/package.json") == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end
  return nil
end

local function scripts(root)
  local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(root .. "/package.json"), "\n"))
  if not ok or type(decoded.scripts) ~= "table" then
    return {}
  end
  local list = {}
  for name, cmd in pairs(decoded.scripts) do
    list[#list + 1] = { name = name, cmd = cmd }
  end
  table.sort(list, function(a, b)
    return a.name < b.name
  end)
  return list
end

local function run_in_term(cmd, cwd)
  local toggleterm = require("toggleterm.terminal")
  if runner_term and runner_term:is_open() then
    runner_term:shutdown()
    runner_term = nil
  end
  runner_term = toggleterm.Terminal:new({
    cmd = cmd,
    dir = cwd,
    direction = "float",
    close_on_exit = false,
    hidden = true,
    on_create = function(t)
      vim.schedule(function()
        t:open()
      end)
    end,
  })
  runner_term:open()
end

local function run_npm_script(name)
  local root = project_root()
  if not root then
    return vim.notify("No package.json found in this project", vim.log.levels.WARN, { title = "Runner" })
  end
  vim.notify("npm run " .. name, nil, { title = "Runner ▶" })
  run_in_term(("npm run %s"):format(vim.fn.shellescape(name)), root)
end

function M.pick_script()
  local root = project_root()
  if not root then
    return vim.notify("No package.json found in this project", vim.log.levels.WARN, { title = "Runner" })
  end
  local list = scripts(root)
  if #list == 0 then
    return vim.notify("package.json has no scripts", vim.log.levels.WARN, { title = "Runner" })
  end
  vim.ui.select(list, {
    prompt = "Run which npm script?",
    format_item = function(item)
      return ("%s  →  %s"):format(item.name, item.cmd)
    end,
  }, function(choice)
    if choice then
      run_npm_script(choice.name)
    end
  end)
end

function M.run_dev()
  local root = project_root()
  if not root then
    return vim.notify("No package.json found in this project", vim.log.levels.WARN, { title = "Runner" })
  end
  local list = scripts(root)
  local preferred = { "dev", "start", "serve" }
  for _, want in ipairs(preferred) do
    for _, s in ipairs(list) do
      if s.name == want then
        return run_npm_script(want)
      end
    end
  end
  M.pick_script()
end

function M.run_file()
  local fname = vim.api.nvim_buf_get_name(0)
  if fname == "" then
    return
  end
  local ft = vim.bo.filetype
  local cmd
  if ft == "typescript" or ft == "typescriptreact" then
    cmd = 'npx tsx "' .. fname .. '"'
  elseif ft == "javascript" or ft == "javascriptreact" then
    cmd = 'node "' .. fname .. '"'
  elseif ft == "python" then
    cmd = 'python3 "' .. fname .. '"'
  elseif ft == "sh" or ft == "zsh" or ft == "bash" then
    cmd = 'bash "' .. fname .. '"'
  else
    cmd = 'node "' .. fname .. '"'
  end
  run_in_term(cmd, vim.fn.fnamemodify(fname, ":h"))
end

function M.stop()
  if runner_term then
    runner_term:shutdown()
    runner_term = nil
    vim.notify("Runner stopped", nil, { title = "Runner ■" })
  end
end

return M
