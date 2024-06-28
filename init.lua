-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- terminal emulator
vim.g.terminal_emulator = "zsh"
vim.opt.shell = "zsh"

-- neo vim font
vim.opt.guifont = "Hack Nerd Font Mono:h12"

require("notify").setup({
  background_colour = "#2E3440",
})

require("headlines").setup({
  markdown = {
    headline_highlights = {
      "Headline1",
      "Headline2",
      "Headline3",
      "Headline4",
      "Headline5",
      "Headline6",
    },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    quote_highlight = "Quote",
  },
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

require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
})

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

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
})
vim.cmd.colorscheme("catppuccin")

if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end
