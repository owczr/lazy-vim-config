-- Highlights matching the github_dark_dimmed colorscheme (see init.lua).
-- Agentic only creates its defaults when a group doesn't exist, so these must
-- be (re)defined after every :colorscheme, which clears all highlights.
local function set_agentic_highlights()
  local ok, p = pcall(require("github-theme.palette").load, "github_dark_dimmed")
  if not ok then
    return
  end

  local hl = vim.api.nvim_set_hl
  hl(0, "AgenticDiffAddWord", { bg = p.success.muted, bold = true })
  hl(0, "AgenticDiffDeleteWord", { bg = p.danger.muted, bold = true })
  hl(0, "AgenticStatusPending", { bg = p.done.muted })
  hl(0, "AgenticStatusCompleted", { bg = p.success.muted })
  hl(0, "AgenticStatusFailed", { bg = p.danger.muted })
  hl(0, "AgenticPermissionButtonAllow", { bg = p.success.emphasis, bold = true })
  hl(0, "AgenticPermissionButtonReject", { bg = p.danger.emphasis, bold = true })
  hl(0, "AgenticPermissionButtonInactive", { bg = p.neutral.muted })
  hl(0, "AgenticTitle", { bg = p.blue.base, fg = "#0B0A11", bold = true })
  hl(0, "AgenticSpinnerGenerating", { fg = p.blue.base, bold = true })
  hl(0, "AgenticSpinnerThinking", { fg = p.magenta.base, bold = true })
  hl(0, "AgenticSpinnerSearching", { fg = p.yellow.base, bold = true })
end

return {
  "carlos-algms/agentic.nvim",

  init = function()
    set_agentic_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("AgenticHighlights", { clear = true }),
      callback = set_agentic_highlights,
    })
  end,

  -- based on: https://neovimcraft.com/plugin/carlos-algms/agentic.nvim/
  --- @type agentic.PartialUserConfig
  opts = {
    acp_providers = {
      ["bob-acp"] = {
        name = "Bob ACP",
        command = "bob",
        args = { "acp", "--trust" },
      },
    },
    provider = "bob-acp",
    -- Nerd Font icons instead of the default emojis
    diagnostic_icons = {
      error = "", -- nf-cod-error
      warn = "", -- nf-cod-warning
      info = "", -- nf-cod-info
      hint = "󰌵", -- nf-cod-lightbulb
    },
    message_icons = {
      thinking = "", -- nf-md-brain
      finished = "󰄬", -- nf-fa-flag_checkered
      stopped = "", -- nf-fa-stop
      error = "", -- nf-fa-times_circle
    },
  },
  -- these are just suggested keymaps; customize as desired
  keys = {
    {
      "<leader>at",
      function()
        require("agentic").toggle()
      end,
      mode = { "n" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<leader>aa",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n" },
      desc = "Add file or selection to Agentic to Context",
    },
    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      mode = { "n" },
      desc = "New Agentic Session",
    },
    {
      "<leader>ar",
      function()
        require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n" },
    },
    {
      "<leader>ad", -- ai Diagnostics
      function()
        require("agentic").add_current_line_diagnostics()
      end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD", -- ai all Diagnostics
      function()
        require("agentic").add_buffer_diagnostics()
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
}
