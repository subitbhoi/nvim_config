return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  event = "InsertEnter",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local luasnip = require("luasnip")
    local vscode_loader = require("luasnip.loaders.from_vscode")

    luasnip.config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      region_check_events = "CursorMoved",
      delete_check_events = "TextChanged,InsertLeave",
      enable_autosnippets = true,
    })

    vscode_loader.lazy_load()

    -- Optional: custom snippet directory for your own web-dev snippets.
    -- Create: ~/.config/nvim/snippets/
    -- vscode_loader.lazy_load({
    --   paths = { vim.fn.stdpath("config") .. "/snippets" },
    -- })
  end,
}
