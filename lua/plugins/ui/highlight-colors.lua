return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    render = "background",
    enable_named_colors = true,
    enable_tailwind = true,

    exclude_filetypes = {
      "lazy",
      "mason",
      "neo-tree",
      "TelescopePrompt",
    },
  },
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
  end,
}
