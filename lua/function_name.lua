--local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

function M.get_current_function()
	local current_node = vim.treesitter.get_node{}

	if not current_node then return '' end

	while current_node do
		if current_node:type() == 'function_declaration' or current_node:type() == 'function_definition' then
			break
		end

		current_node = current_node:parent()
	end

	if not current_node then return '' end

	if vim.bo.filetype == 'c' then

		while current_node do
			if current_node:type() == 'identifier' then
				break
			end
			current_node = current_node:field('declarator')[1]
		end

		if not current_node then return '' end

		local start_row, start_col, end_row, end_col = current_node:range()
		return vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]

		--return current_node:type()
	end
	local start_row, start_col, end_row, end_col = current_node:range()
	return vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})[1]
end

--print(M.get_current_function())
vim.api.nvim_create_user_command('FunctionName', function(_) print(M.get_current_function()) end, {} )

return M
