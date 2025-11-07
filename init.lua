-- bootstrap lazy.nvIm, LazyVim and your plugins
require("config.lazy")
-- require("tokyonight").setup({
--   transparent = true,
--   styles = {
--     -- Style to be applied to different syntax groups
--     -- Value is any valid attr-list value for `:help nvim_set_hl`
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = {},
--     variables = {},
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = "transparent", -- style for sidebars, see below
--     floats = "transparent", -- style for floating windows
--   },
-- })
-- vim.cmd([[colorscheme tokyonight]])
-- Default options
require("github-theme").setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/github-theme",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
    hide_nc_statusline = true, -- Override the underline style for non-active statuslines
    transparent = true, -- Disable setting bg (make neovim's background transparent)
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false, -- Non focused panes set to alternative background
    module_default = true, -- Default enable value for modules
    styles = { -- Style to be applied to different syntax groups
      comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
      functions = "NONE",
      keywords = "NONE",
      variables = "NONE",
      conditionals = "NONE",
      constants = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    darken = { -- Darken floating windows and sidebar-like windows
      floats = true,
      sidebars = {
        enable = true,
        list = {}, -- Apply dark background to specific windows
      },
    },
    modules = { -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme github_dark_default")

require("neotest").setup({
  adapters = {
    require("neotest-python"),
  },
})

local theme = {
  fill = "TabLineFill",
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}
require("tabby").setup({
  line = function(line)
    return {
      {
        { "  ", hl = theme.head },
        line.sep("", theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep("", hl, theme.fill),
          tab.is_current() and "" or "󰆣",
          tab.number(),
          tab.name(),
          tab.close_btn(""),
          line.sep("", hl, theme.fill),
          hl = hl,
          margin = " ",
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep("", theme.win, theme.fill),
          win.is_current() and "" or "",
          win.buf_name(),
          line.sep("", theme.win, theme.fill),
          hl = theme.win,
          margin = " ",
        }
      end),
      {
        line.sep("", theme.tail, theme.fill),
        { "  ", hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})

vim.api.nvim_set_hl(0, "TreesitterContext", {
  bg = nil,
  fg = nil,
})

vim.api.nvim_set_hl(0, "TreesitterContextBottom", {
  underline = true,
  sp = "#444c56",
})

vim.opt.cursorline = false

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
-- stylua: ignore
local custom_theme = require'lualine.themes.auto'

custom_theme.normal.c.bg = nil
custom_theme.insert.c.bg = nil
custom_theme.command.c.bg = nil
custom_theme.terminal.c.bg = nil
custom_theme.visual.c.bg = nil

require("lualine").setup({
  options = {
    theme = custom_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      "%=", --[[ add your center components here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
})

require("devcontainer").setup({})

vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.autoformat = false
end, { desc = "Disable autoformat on save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.autoformat = true
end, { desc = "Enable autoformat on save", bang = true })
