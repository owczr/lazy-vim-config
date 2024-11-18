return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    search_venv_managers = false, -- Disable automatic search for managers like `pyenv` and `pipenv`
    search = true, -- Enable search for custom directories
    search_dirs = { "/home/jakub/.venvs" }, -- Set your venv directory here
    debug = true,
  },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
