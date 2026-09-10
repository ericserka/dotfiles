-- Plugin manager: native vim.pack (Neovim 0.12+), replacing lazy.nvim.
--
-- Plugins are cloned into stdpath("data") .. "/site/pack/core/opt/<name>" and
-- pinned in stdpath("config") .. "/nvim-pack-lock.json".
-- Update everything with `:lua vim.pack.update()`: review the confirmation
-- buffer, `:write` to apply or `:quit` to discard, then `:restart`.
-- Remove a plugin: delete its spec below, restart, then
-- `:lua vim.pack.del({ "<name>" })`.

local function github(repo)
  return "https://github.com/" .. repo
end

-- Hooks must exist before the first vim.pack.add() call so they also fire on
-- the initial install. lazy.nvim ran `build = ':TSUpdate'` for nvim-treesitter
-- after every install/update; while init.lua is being sourced the plugin's
-- user commands do not exist yet, so the Lua function behind :TSUpdate is
-- called directly.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user_pack_hooks", { clear = true }),
  desc = "Run plugin build steps after install or update",
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not event.data.active then
        vim.cmd.packadd({ "nvim-treesitter", bang = true })
      end
      require("nvim-treesitter").update(nil, { summary = true })
    end
  end,
})

vim.pack.add({
  -- Theme
  github("navarasu/onedark.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("nvim-lua/plenary.nvim"),
  -- LSP
  github("mason-org/mason.nvim"),
  github("mason-org/mason-lspconfig.nvim"),
  github("neovim/nvim-lspconfig"),
  -- Treesitter parser and query installer (highlighting itself is native).
  -- `main` is the maintained branch; pinned explicitly because
  -- vim.pack.update() never follows an upstream default-branch change.
  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },
  -- Editor tools
  github("nvim-tree/nvim-tree.lua"), -- File tree
  github("tpope/vim-fugitive"),      -- Git interface
  github("lewis6991/gitsigns.nvim"), -- Git utilities
  { src = github("akinsho/git-conflict.nvim"), version = vim.version.range("*") }, -- Git conflict resolver (latest release)
  github("lukas-reineke/indent-blankline.nvim"), -- Indent tabs/blanklines
  { src = github("akinsho/toggleterm.nvim"), version = vim.version.range("*") }, -- Persistent terminal (latest release; <C-d> to exit without persist)
  github("nvim-lualine/lualine.nvim"), -- Statusline
  -- Editor actions
  github("nvim-telescope/telescope.nvim"),
  github("nvim-pack/nvim-spectre"),
  github("tpope/vim-surround"),
  github("windwp/nvim-autopairs"),
  github("tpope/vim-endwise"),
  github("moll/vim-bbye"),
  -- Highlights the word under the cursor. Kept because expert (Elixir) and
  -- marksman (Markdown) do not implement textDocument/documentHighlight, so
  -- the native LSP highlight covers neither; illuminate falls back to
  -- treesitter/regex there. Retire it once those servers support the method.
  github("RRethy/vim-illuminate"),
  -- Language specific
  github("MeanderingProgrammer/render-markdown.nvim"),
  github("theKnightsOfRohan/csvlens.nvim"),
  github("nvim-java/nvim-java"),
  -- nvim-java dependencies: lazy.nvim installed them implicitly from the
  -- plugin's own package spec; vim.pack does not resolve dependencies.
  github("MunifTanjim/nui.nvim"),
  github("mfussenegger/nvim-dap"),
  { src = github("JavaHello/spring-boot.nvim"), version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0" },
  github("adelarsq/image_preview.nvim"),
  github("folke/noice.nvim"), -- Messages/cmdline UI (depends on nui.nvim above and nvim-notify)
  github("rcarriga/nvim-notify"),
}, { confirm = false }) -- lazy.nvim installed without asking; keep that behavior
