require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
  notify_on_error = true,
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "alejandra" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "yamllint", "yamlfmt" },
  },
})
