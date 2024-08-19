require "nvim-treesitter.configs".setup {
  -- the first five should always be installed
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "elixir",
    "heex",
    "surface",
    "json",
    "haskell",
    "bash",
    "yaml",
    "terraform",
    "sql",
    "earthfile",
    "dockerfile",
    "toml",
    "csv",
    "markdown",
    "javascript",
    "typescript",
    "typst",
    "java"
  },
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  }
}
