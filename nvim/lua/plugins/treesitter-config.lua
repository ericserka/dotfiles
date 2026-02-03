require "nvim-treesitter".setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
-- c, lua, vim, vimdoc, query, markdown, markdown_inline are bundled with
-- Neovim 0.11+. Installing them via nvim-treesitter can cause parser/query
-- version mismatches.
require "nvim-treesitter".install {
    "elixir",
    "heex",
    "surface",
    "json",
    "bash",
    "yaml",
    "terraform",
    "sql",
    "earthfile",
    "dockerfile",
    "toml",
    "csv",
    "javascript",
    "typescript",
    "typst",
    "java",
    "regex",
    "css",
    "scss",
    "python",
    "angular",
    "html",
    "ledger",
    "tsv",
    "prisma",
    "diff",
    "tsx",
    "po",
    "nim"
}
