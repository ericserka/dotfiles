-- LSP client behavior shared by every server (native vim.lsp.config API).
-- Servers are installed and enabled through Mason (plugins/mason-config.lua);
-- per-server overrides live in after/lsp/<server>.lua. Word highlighting
-- stays with vim-illuminate (see pack-config.lua for why).

-- Autocompletion
local cmp = require('cmp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Jump to a diagnostic and show it in a float (what goto_next/goto_prev did).
local function jump_to_diagnostic(count)
  vim.diagnostic.jump({
    count = count,
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  })
end

-- Format on save when the server can format (SQL is excluded).
local function enable_format_on_save(client, bufnr)
  if not client:supports_method("textDocument/formatting", bufnr) or vim.bo[bufnr].filetype == "sql" then
    return
  end
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("user_lsp_format_on_save_" .. bufnr, { clear = true }),
    buffer = bufnr,
    desc = "Format the buffer with LSP before writing it",
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local function set_keymaps(bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buf = bufnr, silent = true, desc = desc })
  end

  map("<C-x>", vim.diagnostic.open_float, "Show diagnostics under the cursor")
  map("gdb", vim.lsp.buf.definition, "Go to definition")
  map("gdt", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition()
  end, "Go to definition in a new tab")
  map("gds", function()
    vim.cmd("rightbelow vsplit")
    vim.lsp.buf.definition()
  end, "Go to definition in a vertical split")
  map("gr", vim.lsp.buf.references, "References")
  map("gi", vim.lsp.buf.implementation, "Implementation")
  map("ga", vim.lsp.buf.code_action, "Code action")
  map("K", function() vim.lsp.buf.hover({ silent = true }) end, "Hover documentation")
  map("td", vim.lsp.buf.type_definition, "Type definition")
  -- [ C ]ode [ S ]ignature
  map("<leader>cs", function() vim.lsp.buf.signature_help({ silent = true }) end, "Signature help")
  -- [ C ]ode [ R ]ename
  map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
  -- [ J ]ump to [ D ]eclaration
  map("<leader>jd", vim.lsp.buf.declaration, "Declaration")
  -- [ J ]ump to [ N ]ext / [ P ]revious diagnostic
  map("<leader>jn", function() jump_to_diagnostic(vim.v.count1) end, "Next diagnostic")
  map("<leader>jp", function() jump_to_diagnostic(-vim.v.count1) end, "Previous diagnostic")
  -- [ C ]ode [ H ]ints
  map("<leader>ch", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")
end

local function on_attach(client, bufnr)
  enable_format_on_save(client, bufnr)
  set_keymaps(bufnr)
end

cmp.setup {
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
})
