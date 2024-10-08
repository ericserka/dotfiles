-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0

-- Line numbers related
vim.o.number = true
vim.o.relativenumber = false

-- Text wrapping related
vim.o.wrap = false                                           -- Setting word wrap to false on all filetypes
vim.cmd('autocmd FileType markdown setlocal wrap linebreak') -- Turning word wrap on again only for markdown files.
vim.o.textwidth = 100

-- Identation related
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Search in file related
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.hlsearch = true

-- Window splits related
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.previewheight = 20

-- Performance/Stability related
vim.opt.termguicolors = true
vim.o.swapfile = false
vim.o.lazyredraw = false
vim.o.updatetime = 100

-- Other preferences
vim.loader.enable()  -- Improves startup time
vim.o.laststatus = 3 -- One statusline for all windows
vim.o.hidden = true
vim.o.foldmethod = "indent"
vim.o.foldenable = false
vim.o.scrolloff = 10
vim.o.errorbells = false
vim.o.numberwidth = 4
vim.o.clipboard = "unnamedplus" -- Synchronizes the system clipboard with Neovim's clipboard
