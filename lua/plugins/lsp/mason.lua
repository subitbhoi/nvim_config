return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = function()
      local icons = require("core.icons")
      local borders = require("core.borders")

      return {
        ui = {
          border = borders.rounded,
          icons = {
            package_installed = icons.mason and icons.mason.package_installed,
            package_pending = icons.mason and icons.mason.package_pending,
            package_uninstalled = icons.mason and icons.mason.package_uninstalled,
          },
        },
      }
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "ts_ls",
        "eslint",
        "jsonls",
        "bashls",
        "yamlls",
        "lua_ls",
      },
      automatic_installation = true,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
