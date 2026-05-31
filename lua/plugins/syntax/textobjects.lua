return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  init = function()
    vim.g.no_plugin_maps = true
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    })
  end,
}
