local function search_count()
  local count = vim.fn.searchcount({ maxcount = 100000, timeout = 500 })
  local search_pattern = vim.fn.getreg('/')

  return string.format('/%s [%d/%d]', search_pattern, count.current, count.total)
end

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
          search_count,
          cond = require("noice").api.status.search.has,
          color = { fg = "#56b6c2" },
        },
      }
    }
  }
)
