return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	  {
	    "folke/lazydev.nvim",
	    ft = "lua", -- only load on lua files
	    opts = {
	      library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	      },
	    },
	  },
      {'cmp-nvim-lsp'},
	},
	config = function()
	    local capabilities = require('cmp_nvim_lsp').default_capabilities()

	    require'lspconfig'.lua_ls.setup{ capabilities = capabilities }
	    require'lspconfig'.clangd.setup{ capabilities = capabilities }
        require'lspconfig'.luau_lsp.setup{
            capabilities = capabilities,
            cmd = {"luau-lsp", "lsp", "--definitions=C:\\Users\\Magnus\\Downloads\\globalTypes.d.luau"}
        }
        require'lspconfig'.jsonls.setup{ capabilities = capabilities }
        require'lspconfig'.selene3p_ls.setup{ filetypes = {'lua', 'luau'}, capabilities = capabilities }
	end
    }
}
