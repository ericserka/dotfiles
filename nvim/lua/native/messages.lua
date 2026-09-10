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

ui2.enable({
  msg = {
    -- Per-kind routing (see :h ui-messages). Kinds not listed stay in the
    -- cmdline ("cmd"). Notification-like kinds go to the ephemeral "msg"
    -- window (bottom-right, hidden after `timeout`), the closest native
    -- analogue to the nvim-notify toasts noice used.
    targets = {
      echomsg = "msg",   -- vim.notify() INFO/WARN, :echomsg
      echoerr = "msg",   -- vim.notify() ERROR, :echoerr
      echo = "msg",      -- plugin messages without history (e.g. gitsigns "Hunk 2 of 3")
      lua_print = "msg", -- print() / vim.print()
      emsg = "msg",      -- Vim errors (E123: ...)
      lua_error = "msg", -- errors raised from Lua
      rpc_error = "msg",
      wmsg = "msg",      -- warnings (W10, "search hit BOTTOM")
      progress = "msg",  -- progress messages (nvim_echo kind "progress")
      typed_cmd = "cmd", -- output of an interactively typed :command stays in the cmdline
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
