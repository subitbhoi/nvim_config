return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = function()
    local icons = require("core.icons")
    local borders = require("core.borders")

    return {
      preset = "modern",

      delay = 300,

      notify = true,

      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },

      win = {
        border = borders.which_key,
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        wo = {
          winblend = 0,
        },
      },

      layout = {
        width = {
          min = 20,
        },
        spacing = 3,
      },

      icons = {
        rules = false, -- Keeps which-key from guessing icons, ensuring it only uses what keymaps.lua provides
        breadcrumb = icons.ui.separator,
        separator = icons.ui.vertical_bar,
        group = "",    -- Prevents the double-folder icon prefix
      },

      sort = {
        "local",
        "order",
        "group",
        "alphanum",
        "mod",
      },
    }
  end,

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
