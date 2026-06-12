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
-- -- Default options
-- require("github-theme").setup({
--   options = {
--     transparent = true, -- Disable setting bg (make neovim's background transparent)
--     terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--   },
-- })
--
-- -- setup must be called before loading
-- vim.cmd("colorscheme github_dark_default")
--
-- vim.opt.background = "dark" -- set this to dark or light
-- vim.cmd("colorscheme oxocarbon")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- -- Default options:
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

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
-- local custom_theme = require'lualine.themes.auto'
--
-- custom_theme.normal.c.bg = nil
-- custom_theme.insert.c.bg = nil
-- custom_theme.command.c.bg = nil
-- custom_theme.terminal.c.bg = nil
-- custom_theme.visual.c.bg = nil

local colors = {
  -- accents (bright)
  blue = "#83a598", -- bright_blue [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)
  cyan = "#8ec07c", -- bright_aqua [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)
  red = "#fb4934", -- bright_red [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)
  violet = "#d3869b", -- bright_purple [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)

  -- neutrals (dark hard base)
  black = "#1d2021", -- dark0_hard [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)[2](https://www.powershellgallery.com/packages/PSConsoleTheme/0.4.0/Content/Themes%5Cbase16-gruvbox-dark-hard.json)
  grey = "#3c3836", -- dark1 (nice “hard” neutral surface) [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)[2](https://www.powershellgallery.com/packages/PSConsoleTheme/0.4.0/Content/Themes%5Cbase16-gruvbox-dark-hard.json)
  white = "#ebdbb2", -- gray/fg-like light tone commonly used as main foreground [1](https://deepwiki.com/morhetz/gruvbox/3.1-color-palette)[2](https://www.powershellgallery.com/packages/PSConsoleTheme/0.4.0/Content/Themes%5Cbase16-gruvbox-dark-hard.json)
}

local custom_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
}

require("lualine").setup({
  options = {
    theme = custom_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      "%=", --[[ add your center components here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
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
