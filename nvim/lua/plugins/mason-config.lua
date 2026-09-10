-- Language servers are installed by Mason on demand. mason-lspconfig maps
-- the names below to Mason packages and, through its default
-- `automatic_enable`, calls vim.lsp.enable() for every installed server.
-- Per-server overrides live in after/lsp/<server>.lua.
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "expert",
    "jsonls",
    "bashls",
    "yamlls",
    "terraformls",
    "sqls",
    "dockerls",
    "docker_compose_language_service",
    "earthlyls",
    "taplo",
    "marksman",
    "ts_ls",
    "tinymist",
    "jdtls",
    "tailwindcss",
    "css_variables",
    "cssls",
    "cssmodules_ls",
    "ruff",
    "angularls",
    "html",
    "prismals",
    "nim_langserver",
    "fish_lsp",
    "zls",
  },
})
