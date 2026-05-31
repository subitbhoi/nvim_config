return {
  "kdheepak/lazygit.nvim",
  version = "*",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function()
    local borders = require("core.borders")

    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.92
    vim.g.lazygit_floating_window_border_chars = borders.rounded
    vim.g.lazygit_floating_window_use_plenary = 1
    vim.g.lazygit_use_neovim_remote = 1
  end,
  config = function()
    -- Optional Telescope extension support.
    local ok, telescope = pcall(require, "telescope")
    if ok then
      pcall(telescope.load_extension, "lazygit")
    end
  end,
}
