-- Native insert-mode completion (vim.lsp.completion, Neovim 0.11+), replacing
-- nvim-cmp + cmp-nvim-lsp.
--
-- The menu opens automatically while typing a word or after one of the
-- server's trigger characters (the previous cmp setup had nvim_lsp as its
-- single source, so buffers without a completion-capable server get no menu,
-- exactly as before). Accepting an item applies the server's side effects
-- (text edits, additional edits such as imports, snippets), and the
-- documentation popup follows the highlighted item.

vim.o.completeopt = "menuone,noselect,popup,fuzzy"

-- cmp opened the menu after every keyword character; the native autotrigger
-- only reacts to the server's trigger characters, so keyword characters are
-- added to that list.
local keyword_characters = { "_" }
for _, range in ipairs({ { "a", "z" }, { "A", "Z" }, { "0", "9" } }) do
  for byte = range[1]:byte(), range[2]:byte() do
    table.insert(keyword_characters, string.char(byte))
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_native_completion", { clear = true }),
  desc = "Enable LSP-driven completion for the attached client",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if not client:supports_method("textDocument/completion", args.buf) then
      return
    end
    local provider = client.server_capabilities.completionProvider
    provider.triggerCharacters = vim.list.unique(
      vim.list_extend(vim.deepcopy(provider.triggerCharacters or {}), keyword_characters)
    )
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end,
})

-- <CR>: confirm the highlighted item, or the first one when nothing is
-- highlighted (the old cmp mapping used `select = true`). Otherwise insert
-- the newline through nvim-autopairs (pair splitting) and vim-endwise
-- (`end` insertion), composed here explicitly: endwise's own <CR> wrapping is
-- disabled because it re-escapes Lua mapping results and corrupts the
-- <Cmd> sequences autopairs returns.
vim.g.endwise_no_mappings = 1

local function confirm_or_newline()
  if vim.fn.pumvisible() == 1 then
    local selected = vim.fn.complete_info({ "selected" }).selected
    return vim.keycode(selected == -1 and "<C-n><C-y>" or "<C-y>")
  end
  local keys = require("nvim-autopairs").autopairs_cr()
  if vim.fn.exists("*EndwiseAppend") == 1 then
    keys = vim.fn.EndwiseAppend(keys)
  end
  return keys
end

-- Scroll the documentation popup of the highlighted item by `lines`; without
-- a popup, run the key's default insert-mode behavior instead.
local function scroll_docs(lines, fallback_key)
  return function()
    -- "preview_winid" is only reported alongside another requested field.
    local win = vim.fn.complete_info({ "selected" }).preview_winid
    if not win or win == 0 or not vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_feedkeys(vim.keycode(fallback_key), "n", false)
      return
    end
    vim.api.nvim_win_call(win, function()
      vim.fn.winrestview({ topline = math.max(1, vim.fn.line("w0") + lines) })
    end)
  end
end

vim.keymap.set("i", "<CR>", confirm_or_newline,
  { expr = true, replace_keycodes = false, desc = "Confirm completion, else newline" })
vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end,
  { desc = "Trigger LSP completion" })
vim.keymap.set("i", "<C-j>", scroll_docs(4, "<C-j>"), { desc = "Scroll completion docs down" })
vim.keymap.set("i", "<C-k>", scroll_docs(-4, "<C-k>"), { desc = "Scroll completion docs up" })
-- <Down>/<Up> already move through the popup menu natively.
