return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      lua = { "stylua" },
      sh = { "shfmt" },
    },

    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)

      local ignored_paths = {
        "/node_modules/",
        "/dist/",
        "/build/",
        "/.next/",
      }

      for _, path in ipairs(ignored_paths) do
        if bufname:find(path, 1, true) then
          return
        end
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
