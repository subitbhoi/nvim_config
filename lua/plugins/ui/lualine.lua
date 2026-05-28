return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local icons = require("core.icons")

    return {
      options = {
        icons_enabled = true,
        theme = "carbonfox",
        globalstatus = true,
        component_separators = "",
        section_separators = "",
        always_divide_middle = false,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = icons.general.mode,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = icons.git.branch,
          },
          {
            "diff",
            symbols = {
              added = icons.git.add .. " ",
              modified = icons.git.change .. " ",
              removed = icons.git.delete .. " ",
            },
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.error .. " ",
              warn = icons.diagnostics.warn .. " ",
              info = icons.diagnostics.info .. " ",
              hint = icons.diagnostics.hint .. " ",
            },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = icons.git.change,
              readonly = icons.general.readonly,
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            "filetype",
            icons_enabled = true,
          },
          "encoding",
          "fileformat",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
