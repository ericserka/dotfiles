-- Inline (ghost-text) completion: native vim.lsp.inline_completion
-- (Neovim 0.12+) driven by copilot-language-server, replacing copilot.vim.
--
-- The server is installed by Mason ("copilot" in plugins/mason-config.lua)
-- and configured by nvim-lspconfig's lsp/copilot.lua plus the buffer gate in
-- after/lsp/copilot.lua. Sign in once with :LspCopilotSignIn if suggestions
-- never appear; the session copilot.vim stored is reused otherwise.
--
-- Keys (insert mode, only in buffers where the server attached), mirroring
-- copilot.vim's defaults:
--   <Tab>        accept the suggestion (falls back to a literal Tab, or moves
--                through the completion menu when it is open)
--   <C-]>        dismiss the suggestion
--   <M-Right>    accept the next word of the suggestion
--   <M-C-Right>  accept the next line of the suggestion

-- Ghost text still to the right of the cursor for `item`, or nil when it
-- cannot be derived (snippet items, or the typed prefix diverged from it).
local function pending_inline_text(item)
  local text = item.insert_text
  if type(text) ~= "string" then
    return nil
  end
  if not item.range then
    return text
  end
  local start_row, start_col = item.range:to_extmark()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local ok, typed = pcall(vim.api.nvim_buf_get_text, 0, start_row, start_col, cursor[1] - 1, cursor[2], {})
  if not ok then
    return nil
  end
  typed = table.concat(typed, "\n")
  if not vim.startswith(text, typed) then
    return nil
  end
  return text:sub(#typed + 1)
end

-- Accept only the leading part of the suggestion matched by `pattern` (a Vim
-- regex, so \k honors 'iskeyword' like copilot.vim's accept-word). Falls back
-- to accepting the whole suggestion when the partial text cannot be derived.
local function accept_partial(pattern)
  return function()
    vim.lsp.inline_completion.get({
      on_accept = function(item)
        local pending = pending_inline_text(item)
        local part = pending and vim.fn.matchstr(pending, pattern) or ""
        if part == "" then
          return item
        end
        vim.api.nvim_paste(part, false, -1)
        return nil -- handled here; skip the default full insertion
      end,
    })
  end
end

-- <Tab>: move through a visible completion menu, else accept the suggestion,
-- else a literal Tab (same precedence as copilot.vim's default fallback).
local function accept_or_tab()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  if not vim.lsp.inline_completion.get() then
    return "<Tab>"
  end
end

-- <C-]>: drop the suggestion, then behave as the regular <C-]>.
local function dismiss()
  vim.lsp.inline_completion.get({ on_accept = function() return nil end })
  return "<C-]>"
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_inline_completion", { clear = true }),
  desc = "Enable LSP inline completion and copilot.vim-style keymaps",
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if not client:supports_method("textDocument/inlineCompletion", bufnr) then
      return
    end
    vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

    local function map(lhs, rhs, desc, expr)
      vim.keymap.set("i", lhs, rhs, { buf = bufnr, expr = expr, desc = desc })
    end
    map("<Tab>", accept_or_tab, "Inline completion: accept (fallback: Tab)", true)
    map("<C-]>", dismiss, "Inline completion: dismiss", true)
    map("<M-Right>", accept_partial([[^\n*\%(\k\@!.\)*\k*]]), "Inline completion: accept word")
    map("<M-C-Right>", accept_partial([[^\n*[^\n]\+]]), "Inline completion: accept line")
  end,
})
