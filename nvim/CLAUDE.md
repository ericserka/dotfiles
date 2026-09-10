# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Eric's personal Neovim configuration (Lua, Neovim 0.12+, plugins managed by the built-in `vim.pack`). There is no build/test/lint tooling — changes take effect when Neovim is restarted (`:restart`) or the edited Lua file is re-sourced (`<leader>rl` runs `:luafile %`).

## Load order & structure

`init.lua` is the single entry point and hard-codes the load order — **order matters**:

1. `lua/settings.lua` — vim options, netrw disabled (nvim-tree replaces it), custom `_G.my_tabline()`, markdown auto-enables `pt_br` spell.
2. `lua/remaps.lua` — global keymaps. `<leader>` is Space. Mnemonic maps are grouped and commented with the `[ X ]` letter convention (e.g. `<leader>kb` = **K**ill **B**uffer).
3. `lua/pack-config.lua` — the **entire plugin list** in one `vim.pack.add({...})` call, plus the `PackChanged` hook that runs nvim-treesitter's parser update after the plugin is installed or updated. Add/remove plugins here. `vim.pack` does not resolve dependencies, so list them explicitly (nvim-java's nui.nvim/nvim-dap/spring-boot.nvim are the current examples).
4. `lua/native/*.lua` — built-in Neovim features configured to replace former plugins: `messages.lua` (ui2 message/cmdline UI with `cmdheight=0`, replaced noice.nvim), `completion.lua` (`vim.lsp.completion`, replaced nvim-cmp), `inline-completion.lua` (`vim.lsp.inline_completion` + copilot-language-server, replaced copilot.vim).
5. `lua/plugins/*.lua` — one file per plugin's `setup()`/config, each explicitly `require`d from `init.lua`. `_other-plugin-requires.lua` batches trivial `setup {}` calls (autopairs, ibl, illuminate, git-conflict, csvlens, render-markdown, image_preview).

When adding a plugin: declare its spec in `pack-config.lua` (plus any dependency it needs), then either add a `require('plugins.<name>-config')` line to `init.lua` (and create the file) or fold a one-line `setup {}` into `_other-plugin-requires.lua`. The plugin is cloned on the next start. `:lua vim.pack.update()` updates everything (review the buffer, `:write` to apply); `:lua vim.pack.del({ "<name>" })` removes a plugin whose spec was dropped.

## LSP architecture

- Servers are declared in `lua/plugins/mason-config.lua` under `mason-lspconfig`'s `ensure_installed` (Mason auto-installs them and `automatic_enable` calls `vim.lsp.enable()`). Add new language servers there.
- `lua/plugins/lsp-config.lua` sets a global default config via `vim.lsp.config("*", { on_attach })`. `on_attach` wires buffer-local LSP keymaps (`gdb` definition, `gr` references, `ga` code action, `<leader>cr` rename, etc.) and **format-on-save** for any server with formatting support (SQL is excluded). Word highlighting is vim-illuminate's job (kept because expert and marksman lack `textDocument/documentHighlight`).
- Per-server overrides live in `after/lsp/<server>.lua` returning a table (Neovim's native `vim.lsp.config` resolution merges these). Examples: `after/lsp/cssls.lua` disables `unknownAtRules` linting, `after/lsp/copilot.lua` gates which buffers Copilot attaches to. This is the place for server-specific config, not `lsp-config.lua`.
- Completion is native (`lua/native/completion.lua`): `vim.lsp.completion` with autotrigger on keyword and server trigger characters, LSP as the only source. Its `<CR>` mapping composes completion confirm → nvim-autopairs → vim-endwise, which is why autopairs' `map_cr` and endwise's own `<CR>` mapping (`g:endwise_no_mappings`) are disabled.

## Conventions

- `nvim-pack-lock.json` pins plugin revisions (written by `vim.pack`, never edited by hand) — commit it alongside plugin changes.
- All new code, comments, and notifications must be American English (`spell` and content may target `pt_br`/`en_us`, but source stays English).
- `cheat_sheet.md` is a personal reference (largely Portuguese); it is not config and is not loaded by Neovim.
- `.luarc.json` declares `vim` as a global to silence lua_ls diagnostics.
