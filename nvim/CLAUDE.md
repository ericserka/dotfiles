# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Eric's personal Neovim configuration (Lua, `lazy.nvim` plugin manager). There is no build/test/lint tooling — changes take effect when Neovim is restarted or the edited Lua file is re-sourced (`<leader>rl` runs `:luafile %`).

## Load order & structure

`init.lua` is the single entry point and hard-codes the load order — **order matters**:

1. `lua/settings.lua` — vim options, netrw disabled (nvim-tree replaces it), custom `_G.my_tabline()`, markdown auto-enables `pt_br` spell.
2. `lua/remaps.lua` — global keymaps. `<leader>` is Space. Mnemonic maps are grouped and commented with the `[ X ]` letter convention (e.g. `<leader>kb` = **K**ill **B**uffer).
3. `lua/lazy-config.lua` — bootstraps `lazy.nvim` and holds the **entire plugin list** in one `require("lazy").setup({...})` call. Add/remove plugins here.
4. `lua/plugins/*.lua` — one file per plugin's `setup()`/config, each explicitly `require`d from `init.lua`. `_other-plugin-requires.lua` batches trivial `setup {}` calls (gitsigns, autopairs, illuminate, ibl).

When adding a plugin: declare its spec in `lazy-config.lua`, then either add a `require('plugins.<name>-config')` line to `init.lua` (and create the file) or fold a one-line `setup {}` into `_other-plugin-requires.lua`.

## LSP architecture

- Servers are declared in `lazy-config.lua` under `mason-lspconfig`'s `ensure_installed` (Mason auto-installs them). Add new language servers there.
- `lua/plugins/lsp-config.lua` sets a global default config via `vim.lsp.config("*", { on_attach, capabilities })`. `on_attach` wires all LSP keymaps (`gdb` definition, `gr` references, `ga` code action, `<leader>cr` rename, etc.), gitsigns hunk maps, and **format-on-save** for any server with `documentFormattingProvider` (SQL is excluded).
- Per-server setting overrides live in `after/lsp/<server>.lua` returning a table (Neovim's native `vim.lsp.config` resolution merges these). Example: `after/lsp/cssls.lua` disables `unknownAtRules` linting. This is the place for server-specific config, not `lsp-config.lua`.
- Completion is `nvim-cmp` with `nvim_lsp` source only; configured in the same `lsp-config.lua`.

## Conventions

- `lazy-lock.json` pins plugin commits — commit it alongside plugin changes.
- All new code, comments, and notifications must be American English (`spell` and content may target `pt_br`/`en_us`, but source stays English).
- `cheat_sheet.md` is a personal reference (largely Portuguese); it is not config and is not loaded by Neovim.
- `.luarc.json` declares `vim` as a global to silence lua_ls diagnostics.
