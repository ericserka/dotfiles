local gitsigns = require("gitsigns")

-- Buffer-local hunk mappings, available in every buffer gitsigns attaches to.
local function on_attach(bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buf = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Hunk navigation (falls back to the diff-mode motions inside :diffthis windows).
  -- The "Hunk N of M" message is forced on: gitsigns turns it off by default
  -- whenever 'shortmess' contains "S", which settings.lua sets for the search count.
  local nav_opts = { navigation_message = true }
  map("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() gitsigns.nav_hunk("next", nav_opts) end)
    return "<Ignore>"
  end, { expr = true, desc = "Next hunk" })
  map("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() gitsigns.nav_hunk("prev", nav_opts) end)
    return "<Ignore>"
  end, { expr = true, desc = "Previous hunk" })

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
