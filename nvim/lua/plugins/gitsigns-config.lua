local gitsigns = require("gitsigns")

local NAV_MESSAGE_ID = "user.gitsigns.nav"

-- Show "Hunk N of M" for the hunk under the cursor, reusing one message id.
local function announce_hunk(bufnr)
  local hunks = gitsigns.get_hunks(bufnr) or {}
  if #hunks == 0 then
    vim.api.nvim_echo({ { "No hunks", "WarningMsg" } }, false, { id = NAV_MESSAGE_ID })
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  for index, hunk in ipairs(hunks) do
    -- A pure deletion has count 0 and sits on the line it was removed after.
    local first = math.max(hunk.added.start, 1)
    local last = math.max(first, hunk.added.start + hunk.added.count - 1)
    if line >= first and line <= last then
      vim.api.nvim_echo({ { ("Hunk %d of %d"):format(index, #hunks) } }, false, { id = NAV_MESSAGE_ID })
      return
    end
  end
end

-- Buffer-local hunk mappings, available in every buffer gitsigns attaches to.
local function on_attach(bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buf = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Hunk navigation (falls back to the diff-mode motions inside :diffthis
  -- windows). The "Hunk N of M" toast is emitted here with a fixed message id
  -- so consecutive jumps update one toast instead of stacking several, which
  -- is what the old noice route (replace = true) did; gitsigns' own message
  -- has no id, so it is disabled and recomputed from the hunk under the cursor.
  local function nav(direction)
    return function()
      if vim.wo.diff then
        return direction == "next" and "]c" or "[c"
      end
      vim.schedule(function()
        gitsigns.nav_hunk(direction, { navigation_message = false }, function() announce_hunk(bufnr) end)
      end)
      return "<Ignore>"
    end
  end
  map("n", "]c", nav("next"), { expr = true, desc = "Next hunk" })
  map("n", "[c", nav("prev"), { expr = true, desc = "Previous hunk" })

  -- Actions
  map("n", "<leader>hu", gitsigns.reset_hunk, { desc = "Reset hunk" })
  map("n", "<leader>hU", gitsigns.reset_buffer, { desc = "Reset buffer" })
  map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, { desc = "Blame line" })
end

gitsigns.setup {
  current_line_blame = true, -- Git blame on the current line
  on_attach = on_attach,
}

vim.api.nvim_set_keymap('n', '<leader>hp', ":Gitsigns preview_hunk<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>hi', ":Gitsigns preview_hunk_inline<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>hs', ":Gitsigns stage_hunk<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>hS', ":Gitsigns stage_buffer<CR>", {})
