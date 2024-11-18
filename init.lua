-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- terminal emulator
vim.g.terminal_emulator = "zsh"
vim.opt.shell = "zsh"

-- neo vim font
vim.opt.guifont = "Hack Nerd Font Mono:h12"

vim.cmd([[colorscheme nord]])
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

local highlights = require("nord").bufferline.highlights({
  italic = true,
  bold = true,
})
require("bufferline").setup({
  options = {
    separator_style = "thin",
  },
  highlights = highlights,
})

-- require("dap")
-- require("dap-python").setup("~/.virtualenvs/debugpy/Scripts/python.exe")
-- require("dap-python").test_runner = "pytest"

require("toggleterm").setup({
  open_mapping = [[<C-\>]],
  insert_mappings = true,
  shade_terminals = false,
  direction = "float",
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return 116
    end
  end,
})

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

-- require("neodev").setup({
--   library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
-- })

-- run tests
vim.api.nvim_set_keymap("n", "tr", ":lua require('neotest').run.run()<CR>", { noremap = true, silent = true })
-- run current file
vim.api.nvim_set_keymap(
  "n",
  "tt",
  ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { noremap = true, silent = true }
)
-- run test in debug mode
vim.api.nvim_set_keymap(
  "n",
  "td",
  ":lua require('neotest').run.run({strategy = 'dap')<CR>",
  { noremap = true, silent = true }
)
-- stop the test
vim.api.nvim_set_keymap("n", "tx", ":lua require('neotest').run.stop()<CR>", { noremap = true, silent = true })
-- test output
vim.api.nvim_set_keymap("n", "to", ":lua require('neotest').output.open()<CR>", { noremap = true, silent = true })
-- test summary
vim.api.nvim_set_keymap("n", "ts", ":lua require('neotest').summary.toggle()<CR>", { noremap = true, silent = true })

-- turn off copilot.lua
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

local dap = require("dap")

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

require("dapui").setup()

-- dap UI keymaps
vim.api.nvim_set_keymap("n", "<F5>", ":lua require('dap').continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>db",
--   ":lua require('dap').toggle_breakpoint()<CR>",
--   { noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dap').restart()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>dq", ":lua require('dap').close()<CR>", { noremap = true, silent = true })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    python = { "black" },
    json = { "jq" },
    c = { "clang-format" },
    sql = { "sql-formatter" },
  },
})

require("telescope").load_extension("projects")

-- require("nvim-treesitter.configs").setup({
--   ensure_installed = { "c", "lua", "python", "sql", "query", "markdown", "markdown_inline", "bash" },
--   auto_install = true,
--   autotag = {
--     enable = true,
--     filetypes = { "c", "lua", "python", "sql", "query", "markdown", "markdown_inline", "bash" },
--   },
--   indent = { enable = true },
--   ignore_install = { "jsonc" },
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
-- })
require("lualine").setup({ highlights = { StatusLine = { bg = "NONE", fg = "NONE" } } })

-- require("lspconfig").pyright.setup({
--   on_attach = function(client)
--     -- Set the Python path for pyright
--     client.config.settings.python.pythonPath = vim.fn.getenv("VIRTUAL_ENV") .. "/bin/python"
--     client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--   end,
--   on_init = function(client)
--     local venv = vim.fn.getenv("VIRTUAL_ENV")
--     if venv and venv ~= "" then
--       client.config.settings.python.pythonPath = venv .. "/bin/python"
--       client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--     end
--   end,
-- })

-- require("nvim-ts-autotag").setup()

-- require("lspconfig").pyright.setup({
--   on_attach = function(client)
--     client.config.settings.python.pythonPath = "/home/jakub/.venvs/ffonline/bin/python"
--     client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--   end,
--   on_init = function(client)
--     local venv = "/home/jakub/.venvs/ffonline"
--     if venv and venv ~= "" then
--       client.config.settings.python.pythonPath = venv .. "/bin/python"
--       client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--     end
--   end,
-- })

-- set the python virtual environment
-- vim.g.python3_host_prog = "/home/jakub/.venvs/ffonline/bin/python"
