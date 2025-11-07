-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Neotest related mappings
vim.keymap.set("n", "<leader>n", "<nop>", { desc = "tests" })
vim.keymap.set("n", "<leader>nr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run nearest test" })

vim.keymap.set(
  "n",
  "<leader>nf",
  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
  { desc = "Run current file" }
)

vim.keymap.set(
  "n",
  "<leader>na",
  "<cmd>lua require('neotest').run.run({ suite = true })<cr>",
  { desc = "Run all tests" }
)

vim.keymap.set(
  "n",
  "<leader>nd",
  "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  { desc = "Debug nearest test" }
)

vim.keymap.set("n", "<leader>ns", "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop test" })

vim.keymap.set("n", "<leader>nn", "<cmd>lua require('neotest').run.attach()<cr>", { desc = "Attach to nearest test" })

vim.keymap.set("n", "<leader>no", "<cmd>lua require('neotest').output.open()<cr>", { desc = "Show test output" })

vim.keymap.set(
  "n",
  "<leader>np",
  "<cmd>lua require('neotest').output_panel.toggle()<cr>",
  { desc = "Toggle output panel" }
)

vim.keymap.set("n", "<leader>nv", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Toggle summary" })

vim.keymap.set(
  "n",
  "<leader>nc",
  "<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>",
  { desc = "Run all tests with CI" }
)

vim.keymap.set("n", "<leader>t", "<nop>", { desc = "tabs" })
vim.keymap.set("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
