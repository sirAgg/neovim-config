vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = 'unnamedplus'
vim.opt.shiftwidth = 4
vim.cmd('set sts=4')
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scl = 'no'
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.list = true
vim.cmd('set lcs+=space:.')

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldlevelstart = 99

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = {
		prefix = function (diagnostic, _, _)
			if diagnostic.severity == vim.diagnostic.severity.ERROR then
				return ''
			elseif diagnostic.severity == vim.diagnostic.severity.WARN then
				return ''
			elseif diagnostic.severity == vim.diagnostic.severity.HINT then
				return ''
			elseif diagnostic.severity == vim.diagnostic.severity.INFO then
				return ''
			else
				return ''
			end
		end
	},
	underline = true,
	floats = {focusable = false},
})

vim.cmd('set path+=**')
vim.cmd('set nocompatible')
vim.cmd('set wildmode=longest,list,full')
vim.cmd('set wildmenu')

vim.cmd.colorscheme('elflord')


require'config.lazy'
require'project_build'
require'function_name'
local rojo = require'rojo_runner'
rojo.setup{}

local rem = require'remedybg'

rem.setup{}

vim.keymap.set("n", '<space><space>x', '<cmd>source%<cr>')
vim.keymap.set("n", '<space>x', ':.lua<cr>')
vim.keymap.set("v", '<space>x', ':lua<cr>')

vim.keymap.set("n", '<space>b', rem.start_debugging)
vim.keymap.set("n", '<space>f', rem.set_breakpoint_at_cursor)
vim.keymap.set("n", '<space><esc>', '<cmd>noh<cr>')
vim.keymap.set("n", '<space><enter>', '<C-^>')

vim.keymap.set('n', '<leader>h', '<C-W>h', { desc = 'Focus window left' })
vim.keymap.set('n', '<leader>j', '<C-W>j', { desc = 'Focus window down' })
vim.keymap.set('n', '<leader>k', '<C-W>k', { desc = 'Focus window up' })
vim.keymap.set('n', '<leader>l', '<C-W>l', { desc = 'Focus window right' })
vim.keymap.set('n', '<leader>H', '<C-W>H', { desc = 'Move window left' })
vim.keymap.set('n', '<leader>J', '<C-W>J', { desc = 'Move window down' })
vim.keymap.set('n', '<leader>K', '<C-W>K', { desc = 'Move window up' })
vim.keymap.set('n', '<leader>L', '<C-W>L', { desc = 'Move window right' })
vim.keymap.set('n', '<leader>q', '<C-W>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>v', '<C-W>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>V', '<C-W>s', { desc = 'Split horizontal' })


vim.keymap.set('n', 'gd', '<C-]>')
vim.keymap.set('n', 'gD', '<C-t>')
vim.keymap.set('n', '<leader>z', '<cmd>lua vim.diagnostic.setqflist()<cr>')

vim.keymap.set('n', 'gn', '<cmd>cnext<cr>')
vim.keymap.set('n', 'gp', '<cmd>cprev<cr>')

vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

if vim.fn.has('win32') or vim.fn.has('win64') then
	vim.keymap.set('n', '<F9>', '<cmd>!explorer .<cr><cr>')
end

vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>m', '<cmd>ClangdSwitchSourceHeader<cr>')

require('telescope').load_extension('projects')
local telescope_builtin = require('telescope.builtin')

vim.api.nvim_create_autocmd({'VimEnter', 'DirChanged'}, {
	desc = 'Loads project specific build commands',
	group = vim.api.nvim_create_augroup('file-finder-decider-group', {clear = true}),
	callback = function()
		if vim.fn.isdirectory('.git') == 1 then
			vim.keymap.set('n', '<leader>e', telescope_builtin.git_files, { desc = 'Telescope find files' })
		else
			vim.keymap.set('n', '<leader>e', telescope_builtin.find_files, { desc = 'Telescope find files' })
		end
	end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufReadPost'}, {
	pattern = {"*.rbxmx", "*.rbxlx"},
	desc = 'RBXMX is XML!!!',
	command = 'set filetype=xml',
})

--local current_hover_win = nil
--vim.api.nvim_create_autocmd({'CursorHold'}, {
--	  desc = 'hover',
--	  callback = function()
--		if current_hover_win and vim.api.nvim_win_is_valid(current_hover_win) then
--			vim.api.nvim_win_close(current_hover_win, true)
--		end
--		  local _, winnr = vim.diagnostic.open_float({border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, focusable = true})
--		current_hover_win = winnr
--	  end
--})

vim.keymap.set('n', '<leader>r', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>t', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Lsp symbols' })
vim.keymap.set('n', '<leader>y', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>u', '<cmd>TodoTelescope<cr>', { desc = 'Telescope Todo' })
vim.keymap.set('n', '<leader>p', require'telescope'.extensions.projects.projects, { desc = 'Projects' })

vim.keymap.set('n', '<leader>g', function() require'neogit'.open({kind = 'split'}) end, { desc = 'Git' })

vim.keymap.set('n', '<leader>o', function() require'oil'.open() end, { desc = 'Oil' })


local harpoon = require'harpoon'
vim.keymap.set('n', '<leader>w', function() harpoon:list():add() end, {desc = 'Harpoon add'})
vim.keymap.set('n', '<leader>a', function() harpoon:list():select(1) end, {desc = 'Harpoon goto 1'})
vim.keymap.set('n', '<leader>s', function() harpoon:list():select(2) end, {desc = 'Harpoon goto 2'})
vim.keymap.set('n', '<leader>d', function() harpoon:list():select(3) end, {desc = 'Harpoon goto 3'})
vim.keymap.set('n', '<leader>f', function() harpoon:list():select(4) end, {desc = 'Harpoon goto 4'})

vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-group', {clear = true} ),
	callback = function()
		vim.highlight.on_yank()
	end,
	}
)

--vim.api.nvim_create_autocmd('DirChanged', {
--	desc = 'Color per project.',
--	callback = function()
--		local cwd = vim.fn.getcwd()
--		local rest, dir = cwd:match("(.*/)(.*)")
--		print(rest)
--		print(dir)
--	end,
--})


function RunSelene()
	if vim.fn.filereadable('selene.toml') == 1 then
		vim.schedule(function()
			local lines = vim.fn.systemlist('selene . -q')
			local list = {}

			local msgs = 0

			for _, line in ipairs(lines) do
				local file_end = line:find(':')
				if not file_end then
					table.insert(list, {text = line, valid = false})
					goto continue
				end
				local file = line:sub(0, file_end-1) -- -1 to skip colon

				local line_num, col_num = string.match(line,':(%d*):(%d*):', file_end)

				--local _, num_end = string.find(line,':(%d*):(%d*):', file_end)

				local type = 'W'
				if line:find('warning%[.*%]', file_end) then
					type = 'W'
				elseif line:find('error%[.*%]', file_end) then
					type = 'E'
				else
					table.insert(list, {text = line, valid = false})
					goto continue
				end

				local text = line:match('.*(%[.*)$', file_end)

				table.insert(list, {filename = file, lnum = line_num, col = col_num, type = type, text = text})
				msgs = msgs+1
				::continue::
			end
			if msgs <= 0 then
				print("no selene errors")
			end
			vim.fn.setqflist(list)
			vim.cmd('cw')
		end)
	end
end

vim.keymap.set('n', '<leader>Z', RunSelene)

vim.o.updatetime = 250
--vim.cmd [[autocmd CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono NFM:h14"
	vim.g.neovide_hide_mouse_when_typing = true

	vim.keymap.set('n', '<leader><', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05 end, { desc = 'Change text size.' })
	vim.keymap.set('n', '<leader>>', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05 end, { desc = 'Change text size.' })
	vim.keymap.set('n', '<F11>', function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end, { desc = 'Toggle fullscreen.'})
end
