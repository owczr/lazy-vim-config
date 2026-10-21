-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "scala",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = [[getline(v:lnum) =~ '^\s*import\>' ? 1 : 0]]
    vim.opt_local.foldlevel = 0
  end,
})
