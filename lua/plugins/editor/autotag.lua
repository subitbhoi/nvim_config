return {
  "windwp/nvim-ts-autotag",

  event = {
    "BufReadPre",
    "BufNewFile",
  },

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
  },

  config = function(_, opts)
    local ok, autotag = pcall(require, "nvim-ts-autotag")
    if not ok then
      vim.notify("nvim-ts-autotag is unavailable", vim.log.levels.ERROR)
      return
    end

    autotag.setup(opts)
  end,
}
