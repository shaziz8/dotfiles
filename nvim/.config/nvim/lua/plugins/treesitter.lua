return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({})
    require('nvim-treesitter').install({ 
      'c',
      'lua' 
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        -- starts highlighting only if a parser exists for this filetype
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
