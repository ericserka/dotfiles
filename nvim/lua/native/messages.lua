-- Message and command-line UI: native ui2 (Neovim 0.12+, EXPERIMENTAL),
-- replacing noice.nvim, nui.nvim and nvim-notify.
--
-- Messages and the cmdline are rendered by vim._core.ui2 instead of the
-- legacy message grid: no hit-enter prompts, the cmdline is highlighted as
-- you type, and :messages / g< open a pager window (q closes it). Long
-- messages collapse with a [+x] spill indicator; press <CR> right after the
-- command or g< to read them in full.
-- To go back to the legacy UI, remove this file's require from init.lua
-- (and drop the 'cmdheight' line below).

-- No permanent cmdline row, like the noice setup this replaces: the cmdline
-- window only shows while typing a command, the output of a typed command
-- stays until the next key, and everything else is an ephemeral toast.
-- Must be set before ui2 loads, which reads 'cmdheight' at that moment.
vim.o.cmdheight = 0

local ok, ui2 = pcall(require, "vim._core.ui2")
if not ok then
  return
end

-- Toast look, close to what nvim-notify gave noice: a rounded border and, per
-- level, an icon, a highlighted title and a matching border color. The
-- "msg" window is the only ui2 window created without an explicit border,
-- so a border set once is kept across repositioning.
local levels = vim.log.levels
-- Icons are Nerd Font glyphs (nvim-notify's defaults), written as escapes
-- because private-use codepoints do not survive every copy/paste.
local toast_styles = {
  [levels.ERROR] = { icon = "\u{f057}", hl = "DiagnosticError" }, -- nf-fa-times_circle
  [levels.WARN] = { icon = "\u{f071}", hl = "DiagnosticWarn" },   -- nf-fa-warning
  [levels.INFO] = { icon = "\u{f05a}", hl = "DiagnosticInfo" },   -- nf-fa-info_circle
  [levels.DEBUG] = { icon = "\u{f188}", hl = "DiagnosticHint" },  -- nf-fa-bug
  [levels.TRACE] = { icon = "\u{270e}", hl = "Comment" },         -- pencil
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_toast_style", { clear = true }),
  pattern = "msg",
  desc = "Give the ui2 toast window a rounded border",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = "rounded" })
  end,
})

local function toast_window()
  local win = ui2.wins and ui2.wins.msg
  return win and vim.api.nvim_win_is_valid(win) and win or nil
end

-- Replaces the default vim.notify: same message kinds and history, plus the
-- level styling above. Errors keep the ErrorMsg body so :messages marks them.
vim.notify = function(msg, level, opts)
  level = level or levels.INFO
  local style = toast_styles[level] or toast_styles[levels.INFO]
  local win = toast_window()
  if win then
    vim.wo[win].winhighlight = "Search:,CurSearch:,IncSearch:,FloatBorder:" .. style.hl
  end
  local chunks = { { style.icon .. " ", style.hl } }
  if opts and opts.title then
    table.insert(chunks, { opts.title .. ": ", style.hl })
  end
  table.insert(chunks, { tostring(msg) })
  vim.api.nvim_echo(chunks, true, { err = level == levels.ERROR })
end

ui2.enable({
  msg = {
    -- Default destination: the ephemeral "msg" window (bottom-right, hidden
    -- after `timeout`), the native analogue of the nvim-notify toasts noice
    -- used. It must be the default, not just listed per kind: with "cmd" as
    -- the default an empty `echo` clears every window, and fugitive emits
    -- empty echoes while streaming `:Git push`/`:Git pull` output.
    target = "msg",
    -- Exceptions that stay in the cmdline window (a trigger wins over a kind).
    targets = {
      typed_cmd = "cmd",  -- output of an interactively typed :command, kept until the next key
      completion = "cmd", -- "match 1 of N" while the completion menu is open
    },
    cmd = { height = 0.5 },                 -- max cmdline height while temporarily expanded
    msg = { height = 0.5, timeout = 4000 }, -- toast window: max height, visibility in ms
    dialog = { height = 0.5 },
    pager = { height = 1 },                 -- :messages / g< pager (1 = full height)
  },
})

-- [ N ]otifications, replacing the noice commands
vim.keymap.set("n", "<leader>nh", "<cmd>messages<CR>", { desc = "Message history (pager; q closes)" })
vim.keymap.set("n", "<leader>nl", "<cmd>1messages<CR>", { desc = "Last message" })
vim.keymap.set("n", "<leader>nd", function()
  vim.cmd('echo ""') -- clears the cmdline message area
  -- Best effort: also clear the ephemeral msg window (internal ui2 API).
  pcall(function() require("vim._core.ui2.messages").msg_clear() end)
end, { desc = "Dismiss messages" })
-- No native error-only filter: open the history and search for E\d\+ in the pager.
vim.keymap.set("n", "<leader>ne", "<cmd>messages<CR>", { desc = "Messages (search errors in the pager)" })
