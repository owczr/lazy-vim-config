if vim.g.vscode then
  vim.cmd([[source C:\\Users\\Jakub.Owczarek\\AppData\\Local\\nvim\\vscode\\settings.vim]])
  -- -- Optional plugin
  -- vim.cmd([[source $HOME/.config/nvim/vscode/easymotion-config.vim]])
else
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end

  -- local bash_options = {
  --   shell = "/cygdrive/c/Users/Jakub.Owczarek/cygwin/bin/bash.exe",
  --   shellcmdflag = "-c",
  --   shellredir = ">%s 2>&1",
  --   shellpipe = "2>&1 | tee %s",
  --   shellquote = "'",
  --   shellxquote = "",
  -- }
  --
  -- for option, value in pairs(bash_options) do
  --   vim.opt[option] = value
  -- end

  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")

  -- terminal emulator
  vim.g.terminal_emulator = "powershell"
  vim.opt.shell = "powershell.exe"
  -- vim.g.terminal_emulator = "bash"
  -- vim.opt.shell = "bash.exe"

  -- neo vim font
  vim.opt.guifont = "Hack Nerd Font Mono:h12"

  -- nord theme configuration
  vim.g.nord_contrast = false
  vim.g.nord_borders = true
  vim.g.nord_disable_background = true
  vim.g.nord_enable_sidebar_background = true
  vim.g.nord_uniform_diff_background = true
  vim.g.nord_italic = true
  vim.g.nord_bold = true

  require("nord").set()

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

  require("neodev").setup({
    library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
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
end
