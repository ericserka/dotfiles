-- Leader key on Space
vim.g.mapleader = " "

------------------------------------
-------- Mneumonical remaps --------
------------------------------------

-- [ T ]ext [ R ]eplace
vim.api.nvim_set_keymap('n', '<leader>tr', ':%s///g<Left><Left><Left>', { noremap = true })

-- [ S ]earch [ C ]lear
vim.api.nvim_set_keymap('n', '<leader>sc', ':noh<CR>', { noremap = true })

-- [ K ]ill [ B ]uffer
vim.api.nvim_set_keymap('n', '<leader>kb', ':Bdelete<CR>', { noremap = true, silent = true })

-- [ R ]un current [ L ]ua file
vim.api.nvim_set_keymap('n', '<leader>rl', ':luafile %<CR>', { noremap = true, silent = true })

-- [ K ]ill [ A ]ll [ B ]uffers
vim.api.nvim_set_keymap('n', '<leader>kab', ':%bd|e#<CR>', { noremap = true, silent = true })

------------------------------------
------ Non mneumonical remaps ------
------------------------------------

-- Copy, cut and paste from system clipboard
vim.api.nvim_set_keymap('v', '<C-y>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '"+p', { noremap = true, silent = true })

-- Navigate splits more easily
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true, silent = true })

-- Resize splits
vim.api.nvim_set_keymap('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })

-- Navigate buffers
vim.api.nvim_set_keymap('n', '<S-h>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

-- Cut and paste
vim.api.nvim_set_keymap('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true })
