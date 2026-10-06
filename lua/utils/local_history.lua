-- Local History — WebStorm-style per-file snapshots.
-- A snapshot is taken automatically on every save (see config/autocmds.lua)
-- and after ~3 minutes of idle editing. Snapshots live in:
--   stdpath('state')/local-history/<hash-of-path>/<timestamp>--<filename>
-- Browse/restore them with :LocalHistory or <leader>hl (telescope picker:
--   <CR> diff against current file, <C-r> restore snapshot).
local M = {}

local dir = vim.fn.stdpath("state") .. "/local-history"
local MAX_PER_FILE = 200 -- keep the newest N snapshots per file
local MAX_SIZE = 2 * 1024 * 1024 -- skip files bigger than 2MB
local idle_timer = nil

local function hash(s)
  local h = 5381
  for i = 1, #s do
    h = ((h * 33) + s:byte(i)) % 0xffffffff
  end
  return string.format("%08x", h)
end

local function file_dir(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return nil
  end
  return dir .. "/" .. hash(name)
end

local last_snapshot = {}

function M.snapshot(buf)
  buf = buf or 0
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return
  end
  local stat = vim.uv.fs_stat(name)
  if stat and stat.size > MAX_SIZE then
    return
  end
  -- debounce: skip if a snapshot was taken for this buffer < 5s ago
  local now = os.time()
  if last_snapshot[buf] and now - last_snapshot[buf] < 5 then
    return
  end
  last_snapshot[buf] = now

  local fdir = file_dir(buf)
  if not fdir then
    return
  end
  vim.fn.mkdir(fdir, "p")

  local ts = os.date("%Y%m%d-%H%M%S")
  local base = vim.fn.fnamemodify(name, ":t")
  local dest = ("%s/%s--%s"):format(fdir, ts, base)

  -- read from disk (snapshot BEFORE write happens via BufWritePre)
  local content = vim.fn.readfile(name, "b")
  if type(content) == "table" then
    vim.fn.writefile(content, dest, "b")
  end

  M.prune(fdir)
end

function M.prune(fdir)
  local files = vim.fn.readdir(fdir)
  if #files <= MAX_PER_FILE then
    return
  end
  table.sort(files, function(a, b)
    return a > b -- newest first (timestamps sort lexicographically)
  end)
  for i = MAX_PER_FILE + 1, #files do
    vim.fn.delete(fdir .. "/" .. files[i])
  end
end

-- Idle snapshot: every 3 minutes of inactivity in the current buffer
function M.start_idle_timer()
  if idle_timer then
    return
  end
  idle_timer = vim.uv.new_timer()
  idle_timer:start(3 * 60 * 1000, 3 * 60 * 1000, vim.schedule_wrap(function()
    if vim.bo.modified then
      -- snapshot the *current* in-memory content
      local buf = vim.api.nvim_get_current_buf()
      local name = vim.api.nvim_buf_get_name(buf)
      local fdir = file_dir(buf)
      if name ~= "" and fdir then
        vim.fn.mkdir(fdir, "p")
        local ts = os.date("%Y%m%d-%H%M%S") .. "-idle"
        local base = vim.fn.fnamemodify(name, ":t")
        vim.fn.writefile(vim.api.nvim_buf_get_lines(buf, 0, -1, false), fdir .. "/" .. ts .. "--" .. base, "b")
        M.prune(fdir)
      end
    end
  end))
end

---------------------------------------------------------------
-- Telescope picker over this file's snapshots
---------------------------------------------------------------
function M.browse()
  local fdir = file_dir(0)
  if not fdir or vim.fn.isdirectory(fdir) == 0 then
    return vim.notify("No local history for this file yet", vim.log.levels.WARN, { title = "Local History" })
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  local files = vim.fn.readdir(fdir)
  table.sort(files, function(a, b)
    return a > b
  end)
  local entries = {}
  for _, f in ipairs(files) do
    local ts = f:match("^(%d%d%d%d%d%d%d%d%-%d%d%d%d%d%d)")
    local label = ts and os.date("%Y-%m-%d %H:%M:%S", vim.fn.strptime("%Y%m%d-%H%M%S", ts)) or f
    entries[#entries + 1] = { path = fdir .. "/" .. f, display = label .. (f:find("idle") and "  (auto)" or "") }
  end

  local diff_snapshot = function(prompt_bufnr)
    local entry = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)
    local current = vim.api.nvim_buf_get_name(0) -- the file currently open
    vim.cmd("tabnew " .. vim.fn.fnameescape(entry.path)) -- snapshot on the left
    vim.cmd("vsplit " .. vim.fn.fnameescape(current)) -- current file on the right
    vim.cmd("windo diffthis")
  end

  local restore_snapshot = function(prompt_bufnr)
    local entry = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)
    local cur = vim.api.nvim_buf_get_name(0)
    if cur == "" then
      return
    end
    vim.fn.writefile(vim.fn.readfile(cur, "b"), cur .. ".local-history.bak", "b")
    vim.fn.writefile(vim.fn.readfile(entry.path, "b"), cur, "b")
    vim.cmd("edit " .. vim.fn.fnameescape(cur))
    vim.notify("Snapshot restored (backup: " .. vim.fn.fnamemodify(cur, ":t") .. ".local-history.bak)", nil, { title = "Local History" })
  end

  pickers
    .new({}, {
      prompt_title = "Local History — " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"),
      layout_strategy = "vertical",
      previewer = previewers.vim_buffer_cat.new({}),
      finder = finders.new_table({
        results = entries,
        entry_maker = function(e)
          return {
            value = e.path,
            display = e.display,
            ordinal = e.display,
            path = e.path,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-r>", restore_snapshot)
        map("n", "<C-r>", restore_snapshot)
        actions.select_default:replace(diff_snapshot)
        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command("LocalHistory", M.browse, { desc = "Browse local history of current file" })

M.start_idle_timer()

return M
