-- Merged on top of nvim-lspconfig's lsp/copilot.lua (see :h lsp-config-merge).
-- Mirrors copilot.vim's default buffer gate: no Copilot in VCS message
-- buffers, in buffers without a filetype, or in special buffers
-- (help/quickfix/terminal/prompt). Not calling on_dir() skips the attach.
local disabled_filetypes = { gitcommit = true, gitrebase = true, hgcommit = true, svn = true, cvs = true }

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local filetype = vim.bo[bufnr].filetype
    local primary_filetype = filetype:match("^[^.]*")
    if filetype == "" or disabled_filetypes[primary_filetype] or vim.bo[bufnr].buftype ~= "" then
      return
    end
    -- nil outside a git repository: the server still starts in single-file mode, like copilot.vim.
    on_dir(vim.fs.root(bufnr, { ".git" }))
  end,
}
