return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      transparent = false,
      terminal_colors = true,
      dim_inactive = false,
      module_default = true,
      styles = {
        comments = "italic",
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "bold",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd.colorscheme("carbonfox")
  end,
}
