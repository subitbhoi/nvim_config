return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  opts = {
    disable_filetype = {
      "TelescopePrompt",
      "snacks_picker_input",
      "spectre_panel",
    },
    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    enable_abbr = false,
    break_undo = true,
    check_ts = true,
    ts_config = {
      javascript = { "template_string" },
      typescript = { "template_string" },
      javascriptreact = { "template_string" },
      typescriptreact = { "template_string" },
      lua = { "string" },
    },
    map_cr = true,
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    local ok_cmp, cmp = pcall(require, "cmp")
    if ok_cmp then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
