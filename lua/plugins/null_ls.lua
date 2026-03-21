return {
	'nvimtools/none-ls.nvim',
	config = function()
		local null_ls = require('null-ls')
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.selene.with({
					condition = function(utils)
						return utils.root_has_file("selene.toml")
					end,
					timeout = 500,
					--method = null_ls.methods.DIAGNOSTICS_ON_SAVE
				})
			}
		})
	end
}
