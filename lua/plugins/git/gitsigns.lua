return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local icons = require("core.icons")
    local borders = require("core.borders")

    local git = icons.git

    require("gitsigns").setup({
      signs = {
        add = { text = git.add },
        change = { text = git.change },
        delete = { text = git.delete },
        topdelete = { text = git.topdelete or git.delete },
        changedelete = { text = git.change },
        untracked = { text = git.untracked },
      },

      signs_staged = {
        add = { text = git.add },
        change = { text = git.change },
        delete = { text = git.delete },
        topdelete = { text = git.topdelete or git.delete },
        changedelete = { text = git.change },
        untracked = { text = git.untracked },
      },

      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      sign_priority = 6,

      watch_gitdir = {
        follow_files = true,
      },

      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 700,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },

      preview_config = {
        border = borders.rounded,
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
  end,
}
