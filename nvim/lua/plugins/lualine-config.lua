require("lualine").setup(
  {
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 1
        }
      },
      lualine_x = {
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#56b6c2" },
        },
      }
    }
  }
)
