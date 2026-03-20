local toggleterm = require("toggleterm")

toggleterm.setup({
  open_mapping = [[<C-\>]], -- Same to hide and persist session
  direction = 'float',
  float_opts = {
    border = 'curved'
  }
})

-- Remap exit terminal mode hotkey
vim.api.nvim_set_keymap('t', '<C-d>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Test project
vim.api.nvim_set_keymap(
  'n',
  '<leader>tp',
  ':TermExec cmd="mix test" dir="."<CR>',
  { noremap = true, silent = true }
)

-- Test file
vim.api.nvim_set_keymap(
  'n',
  '<leader>tf',
  ':TermExec cmd="mix test %" dir="."<CR>',
  { noremap = true, silent = true }
)

-- Pre commit
local pre_commit_cmd = table.concat({
  "mix format",
  "mix compile --warnings-as-errors",
  "mix xref graph --format cycles --label compile-connected --min-cycle-label 2 --fail-above 0",
  "mix deps.unlock --check-unused",
  "mix credo --ignore design",
  "mix sobelow --config --skip",
  "mix coveralls",
}, " && ")

vim.api.nvim_set_keymap('n', '<leader>pc',
  ':TermExec cmd="' .. pre_commit_cmd .. '" dir="."<CR>',
  { noremap = true, silent = true })

-- Test on cursor
vim.api.nvim_set_keymap(
  'n',
  '<leader>tt',
  ':lua TestWithLineNumber()<CR>',
  { noremap = true, silent = true }
)

function TestWithLineNumber()
  local line_number = vim.fn.line('.')

  vim.cmd(
    string.format(
      ':TermExec cmd="mix test %s:%d" dir="."<CR>',
      vim.fn.expand('%:p'),
      line_number
    )
  )
end
