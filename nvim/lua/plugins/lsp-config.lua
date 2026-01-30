-- Autocompletion
local cmp = require('cmp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Git Signs
require('gitsigns').setup()

local on_attach = function(client, bufnr)
  -- Format on save if documentFormattingProvider
  if client.server_capabilities.documentFormattingProvider and vim.bo.filetype ~= "sql" then
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', '<C-x>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', '<leader>jd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', '<leader>jn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', '<leader>jp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', '<leader>ch',
    '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })<CR>', opts)

  -- Gitsigns
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opt)
    opt = opt or {}
    opt.buffer = bufnr
    vim.keymap.set(mode, l, r, opt)
  end

  -- -- Next Hunk Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- -- Previous Hunk Navigation
  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- -- Git blame on line
  gs.toggle_current_line_blame()

  -- -- Actions
  map('n', '<leader>hu', gs.reset_hunk)
  map('n', '<leader>hU', gs.reset_buffer)
  map('n', '<leader>hb', function() gs.blame_line { full = true } end)
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

-- setup nvim-java before lspconfig
-- removing java setup temporarily
-- require('java').setup()

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities
})
