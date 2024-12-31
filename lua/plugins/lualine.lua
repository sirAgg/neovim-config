return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require('lualine').setup {
			  options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
				  statusline = {},
				  winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
				  statusline = 100,
				  tabline = 100,
				  winbar = 100,
				}
			  },
			  sections = {
				lualine_a = {'mode'},
				lualine_b = {'diagnostics'},
				lualine_c = {'filename', require'function_name'.get_current_function},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			  },
			  inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename', require'function_name'.get_current_function},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			  },
			  tabline = {},
			  winbar = {},
			  inactive_winbar = {},
			  extensions = {}
			}
		end
	}
}