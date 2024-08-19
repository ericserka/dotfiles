-- ripgrep is prerequisite (sudo apt install ripgrep)

local spectre = require('spectre')

spectre.setup({
  live_update = true,
  default = {
    find = {
      cmd = "rg", options = {}
    }
  }
})

vim.keymap.set('n', '<leader>ps', spectre.open, {})
