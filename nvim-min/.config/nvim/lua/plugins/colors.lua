local function enable_blur()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
  {
    'shaunsingh/nord.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nord]])
      enable_blur()
    end,
  },

  {
    'nvim-lualine/lualine.nvim', -- neovim bar
    dependencies = { 
	'nvim-tree/nvim-web-devicons', 
    },
    opts = {
	theme = 'nord',
    }
  }

}
