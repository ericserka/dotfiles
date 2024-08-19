local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath
    }
  )
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup(
  {
    -- Theme
    { "navarasu/onedark.nvim" },
    { "nvim-tree/nvim-web-devicons",      lazy = false },
    { "nvim-lua/plenary.nvim",            lazy = false },
    -- LSP
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
      "hrsh7th/nvim-cmp",
      dependencies = { { "hrsh7th/cmp-nvim-lsp" } }
    },
    { "nvim-treesitter/nvim-treesitter" },
    -- Editor tools
    { "kyazdani42/nvim-tree.lua",       lazy = false }, -- File tree
    { "tpope/vim-fugitive" },                           -- Git interface
    { "lewis6991/gitsigns.nvim" },                      -- Git utilities
    {
      "akinsho/git-conflict.nvim",
      version = "*",
      config = true
    },                                         -- Git conflict resolver
    { "lukas-reineke/indent-blankline.nvim" }, -- Indent tabs/blanklines
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = true
    },                               -- Persistent terminal (<C-d> to exit without persist)
    { "nvim-lualine/lualine.nvim" }, -- Statusline
    -- Editor actions
    { "nvim-telescope/telescope.nvim",      tag = "0.1.5" },
    { "nvim-pack/nvim-spectre" },
    { "tpope/vim-commentary" },
    { "tpope/vim-surround" },
    { "windwp/nvim-autopairs" },
    { "RRethy/vim-illuminate" }, -- Highlight exact same words on buffer
    { "tpope/vim-endwise",                  lazy = false },
    { "moll/vim-bbye" },
    { "github/copilot.vim" },
    -- Language specific
    { "elixir-editors/vim-elixir" },
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function()
        vim.fn["mkdp#util#install"]()
      end
    },
    {
      "theKnightsOfRohan/csvlens.nvim",
      dependencies = {
        "akinsho/toggleterm.nvim"
      },
      config = true,
      opts = {}
    },
    { "nvim-java/nvim-java" },
  }
)
