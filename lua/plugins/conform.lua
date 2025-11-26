return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "isort", "black" },
      json = { "jq" },
      html = { "prettier" },
    },
  },
}
