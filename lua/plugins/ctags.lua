return {
  {
    "wsdjeg/ctags.nvim",
    dependencies = { "wsdjeg/job.nvim", "wsdjeg/rooter.nvim" },
    config = function()
      require("rooter").reg_callback(require("ctags").update)
    end,
  },
}
