require("nvim-tree").setup {
  filters = {
    dotfiles = false
  },
  view = {
    width = 40,
    preserve_window_proportions = false
  },
  update_focused_file = {
    enable = true
  },
  actions = {
    open_file = {
      resize_window = false
    }
  }
}

-- Open filetree
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Reset filetree to default size
vim.keymap.set("n", "<leader>rt", require("nvim-tree.view").resize, { noremap = true, silent = true })
