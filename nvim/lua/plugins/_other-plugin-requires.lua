require("nvim-autopairs").setup { map_cr = false } -- <CR> is composed in lua/native/completion.lua
require("ibl").setup {}
require("illuminate").configure {} -- Highlight exact same words on buffer (LSP, treesitter or regex)
require("git-conflict").setup {}
require("csvlens").setup {}
require("render-markdown").setup {}
require("image_preview").setup {}
