-- Neovim config (Lua, plugins managed by the native vim.pack)
require('settings')
require('remaps')
require('pack-config')

-- Native features that replaced plugins
require('native.completion')

-- Plugin configs
require('plugins.theme')
require('plugins.mason-config')
require('plugins.lsp-config')
require('plugins.nvim-tree-config')
require('plugins.treesitter-config')
require('plugins.telescope-config')
require('plugins.spectre-config')
require('plugins.fugitive-config')
require('plugins.toggleterm-config')
require('plugins._other-plugin-requires')
require('plugins.gitsigns-config')
require('plugins.lualine-config')
require('plugins.csvlens-config')
require('plugins.java-config')
require('plugins.noice-config')
