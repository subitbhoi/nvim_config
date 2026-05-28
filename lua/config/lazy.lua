require("lazy").setup({
  spec = {
   { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.navigation" },
    { import = "plugins.syntax" },
    { import = "plugins.ui" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
