return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black", "ruff_fix", "ruff_organize_imports" },
      json = { "jq" },
      html = { "prettier" },
    },
  },
}
