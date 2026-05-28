return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local icons = require("core.icons")
    local borders = require("core.borders")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end
    
   vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN]  = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT]  = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO]  = icons.diagnostics.info,
    },
  },
  virtual_text = {
    spacing = 4,
    prefix = "",
  },
  float = {
    border = borders.rounded,
    source = "always",
    header = "",
    prefix = "",
  },
})

     local function setup(server, opts)
      vim.lsp.config(server, vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, opts or {}))
    end

    -- Web stack
    setup("html")
    setup("cssls")
    setup("tailwindcss")
    setup("ts_ls")
    setup("eslint")
    setup("jsonls")

    -- Backend / general
    setup("bashls")
    setup("yamlls")

    -- Lua for Neovim config
    setup("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}
