return {
   {
    'brenoprata10/nvim-highlight-colors', -- highlight hex color
    opts = {},
   }, 

   {
     "NeogitOrg/neogit",
      lazy = true,
      dependencies = {
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
      },
      cmd = "Neogit",
      keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
      },

      init = function()
	local function set_hl()
	  local hl = vim.api.nvim_set_hl
	  hl(0, "NeogitDiffAdd",          { fg = "#a3be8c", bg = "#35423a" })
	  hl(0, "NeogitDiffAddCursor",    { fg = "#a3be8c", bg = "#3d4f42" })
	  hl(0, "NeogitDiffDelete",       { fg = "#bf616a", bg = "#47373d" })
	  hl(0, "NeogitDiffDeleteCursor", { fg = "#bf616a", bg = "#523d44" })
	end

        set_hl()
        vim.api.nvim_create_autocmd("ColorScheme", {
	  callback = function() vim.schedule(set_hl) end,
	})
	vim.api.nvim_create_autocmd("FileType", {
	  pattern = { "NeogitStatus", "NeogitCommitView", "NeogitDiffView" },
	  callback = function() vim.schedule(set_hl) end,
	})
      end,
   }
}
