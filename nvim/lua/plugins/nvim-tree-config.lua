local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>pp', function()
    local node = api.tree.get_node_under_cursor()
    if node and node.type == "file" then
      require('image_preview').PreviewImage(node.absolute_path)
    end
  end, opts('Preview Image'))
end

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
  },
  on_attach = my_on_attach
}

-- Open filetree
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Reset filetree to default size
vim.keymap.set("n", "<leader>rt", require("nvim-tree.view").resize, { noremap = true, silent = true })
