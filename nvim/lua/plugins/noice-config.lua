require("noice").setup({
  routes = {
    {
      filter = {
        event = "msg_show",
        find = "nvim%-treesitter/install",
      },
      opts = { skip = true },
    },
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  messages = {
    view_search = false
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,          -- use a classic bottom cmdline for search
    command_palette = true,        -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false,            -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,        -- add a border to hover docs and signature help
  },
})

vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end)

vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end)

vim.keymap.set("n", "<leader>nd", function()
  require("noice").cmd("dismiss")
end)

vim.keymap.set("n", "<leader>ne", function()
  require("noice").cmd("errors")
end)
