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

		vim.lsp.config('clangd', {
			capabilities = capabilities
		})

		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
			settings = {
				lua = {
					diagnostics = {
						globals = {"vim"}
					}
				}
			}
		})
		vim.lsp.config('luau_lsp', {
			capabilities = capabilities,
			cmd = {"luau-lsp", "lsp", "--definitions=" .. vim.api.nvim_get_runtime_file('roblox/globalTypes.d.luau', false)[1]}, --, "--flag:LuauSolverV2=true"
		})
		vim.lsp.config('jsonls', {
			capabilities = capabilities
		})

		vim.lsp.config('ltex-plus', {
			cmd = {'ltex-ls-plus'},
			ltex = {
				language = 'sv'
			},
			enabled = { "bib", "context", "gitcommit", "html", "markdown", "org", "pandoc", "plaintex", "quarto", "mail", "mdx", "rmd", "rnoweb", "rst", "tex", "latex", "text", "typst", "xhtml", "md"},
		})

		vim.lsp.enable({'clangd', 'luau_lsp', 'lua_ls', 'jsonls'})
	end
	}
}
