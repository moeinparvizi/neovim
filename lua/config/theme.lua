-- Persisted colorscheme system.
-- <leader>ut opens the theme picker (telescope, live preview).
-- Whatever theme you press <CR> on is saved and reloaded on startup.
local M = {}

local DEFAULT_THEME = "tokyonight-night"
local state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

M.AVAILABLE = {
  "tokyonight-night",
  "tokyonight-day",
  "tokyonight-storm",
  "tokyonight-moon",
  "catppuccin-macchiato",
  "catppuccin-latte",
  "gruvbox",
  "kanagawa-wave",
  "rose-pine",
  "onedark",
  "nightfox",
  "habamax",
}

function M.get()
  local f = io.open(state_file, "r")
  if not f then
    return DEFAULT_THEME
  end
  local name = f:read("*l") or ""
  f:close()
  if name == "" then
    return DEFAULT_THEME
  end
  return name
end

function M.set(name)
  local ok = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("Theme not found: " .. name, vim.log.levels.WARN)
    return
  end
  local f = io.open(state_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

function M.picker()
  -- unique union of every installed theme + the curated list
  local seen, themes = {}, {}
  for _, t in ipairs(vim.fn.getcompletion("", "color")) do
    seen[t] = true
    themes[#themes + 1] = t
  end
  for _, t in ipairs(M.AVAILABLE) do
    if not seen[t] then
      seen[t] = true
      themes[#themes + 1] = t
    end
  end
  require("telescope.builtin").colorscheme({
    enable_preview = true,
    colors = themes,
  })
end

-- Persist whatever theme gets activated (also catches telescope previews —
-- the final one before quitting is the one that sticks)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("theme-persist", { clear = true }),
  callback = function(args)
    local f = io.open(state_file, "w")
    if f then
      f:write(args.match)
      f:close()
    end
  end,
})

function M.load()
  vim.schedule(function()
    M.set(M.get())
  end)
end

return M
