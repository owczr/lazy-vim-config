local map = vim.keymap.set

return {
  "scalameta/nvim-metals",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    -- Get capabilities from cmp_nvim_lsp (loaded as dependency of nvim-cmp)
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      metals_config.capabilities = cmp_nvim_lsp.default_capabilities()
    end

    -- Enable semantic tokens for better syntax highlighting
    metals_config.init_options.statusBarProvider = "on"
    metals_config.tvp = {
      panel_width = 40,
      panel_alignment = "left",
      toggle_node_mapping = "<CR>",
      node_command_mapping = "r",
      collapsed_sign = "▸",
      expanded_sign = "▾",
      icons = {
        enabled = false,
        symbols = {
          object = "",
          trait = "",
          class = "ﭰ",
          interface = "",
          val = "",
          var = "",
          method = "ﬦ",
          enum = "",
          field = "",
          package = "",
        },
      },
    }

    -- Settings for Metals
    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
      },
      testUserInterface = "Test Explorer",
    }

    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()
      -- Enable document highlights
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      map("n", "<leader>mh", function()
        require("metals").hover_worksheet()
      end, { buffer = bufnr, desc = "Metals: Hover Worksheet" })

      -- Metals commands
      map("n", "<leader>mc", function()
        require("metals").commands()
      end, { buffer = bufnr, desc = "Metals: Commands" })

      map("n", "<leader>mi", function()
        require("metals").toggle_setting("showImplicitArguments")
      end, { buffer = bufnr, desc = "Metals: Toggle Implicit Arguments" })

      map("n", "<leader>mt", function()
        require("metals.tvp").toggle_tree_view()
      end, { buffer = bufnr, desc = "Metals: Toggle Tree View" })

      map("n", "<leader>mr", function()
        require("metals.tvp").reveal_in_tree()
      end, { buffer = bufnr, desc = "Metals: Reveal In Tree" })
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
