return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Load before colorschemes so highlights clear properly
  opts = {
    -- Automatically enable transparency on launch
    auto_pivot = true,
    extra_groups = {
      "NormalFloat", -- Floating windows
      "FloatBorder", -- Borders of floating windows
      "FloatTitle",  -- Titles on float windows
      "NormalNC",    -- Non-current windows
      "NvimTreeNormal",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "TelescopeNormal",
      "TelescopeBorder",
      "CursorLine",   -- Highlight line under cursor
      "CursorLineNr", 
      "LineNr",       -- Line numbers column
      "SignColumn",   -- Git / diagnostics column
      "StatusLine",   -- Statusbar background
      "StatusLineNC",
      "WinSeparator", -- Split window borders
    },
  },
  config = function(_, opts)
    local transparent = require("transparent")
    transparent.setup(opts)
    
    -- Force clear third-party components that use dynamic prefixes
    transparent.clear_prefix("BufferLine")
    transparent.clear_prefix("NeoTree")
    transparent.clear_prefix("lualine")
    transparent.clear_prefix("NvimTree")

    -- Ensure transparency is active on startup
    vim.cmd("TransparentEnable")
  end,
}
