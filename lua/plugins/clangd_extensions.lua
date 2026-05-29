return {
	{
		'dchinmay2/clangd_extensions.nvim',
		config = function()
			require("clangd_extensions").setup({
				ast = {
					--[[ These are unicode, should be available in any font
					role_icons = {
						type = "🄣",
						declaration = "🄓",
						expression = "🄔",
						statement = ";",
						specifier = "🄢",
						["template argument"] = "🆃",
					},
					kind_icons = {
						Compound = "🄲",
						Recovery = "🅁",
						TranslationUnit = "🅄",
						PackExpansion = "🄿",
						TemplateTypeParm = "🅃",
						TemplateTemplateParm = "🅃",
						TemplateParamObject = "🅃",
					},--]]
					-- --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
					role_icons = {
						type = "",
						declaration = "",
						expression = "",
						specifier = "",
						statement = "",
						["template argument"] = "",
					},

					kind_icons = {
						Compound = "",
						Recovery = "",
						TranslationUnit = "",
						PackExpansion = "",
						TemplateTypeParm = "",
						TemplateTemplateParm = "",
						TemplateParamObject = "",
					}, -- ]]

					highlights = {
						detail = "Comment",
					},
				},
				memory_usage = {
					border = "none",
				},
				symbol_info = {
					border = "none",
				},
			})
		end
	}
}
