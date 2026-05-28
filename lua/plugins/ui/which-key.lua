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
        breadcrumb = icons.ui.separator,
        separator = icons.ui.vertical_bar,
        group = icons.ui.group,
      },

      sort = {
        "local",
        "order",
        "group",
        "alphanum",
        "mod",
      },

      spec = {
        {
          "<leader>f",
          group = icons.general.search .. " Find",
        },

        {
          "<leader>g",
          group = icons.git.git .. " Git",
        },

        {
          "<leader>b",
          group = icons.navigation.buffer .. " Buffers",
        },

        {
          "<leader>l",
          group = icons.lsp.server .. " LSP",
        },

        {
          "<leader>u",
          group = icons.general.ui .. " UI",
        },

        {
          "<leader>s",
         group = icons.ui.split .. " Splits",
        },

        {
          "<leader>t",
          group = icons.general.terminal .. " Terminal",
        },

        {
          "<leader>c",
          group = icons.general.command .. " Code",
        },
      },
    }
  end,

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
