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
