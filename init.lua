vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = 'unnamedplus'
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scl = 'no'
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldlevelstart = 99

require'config.lazy'
require'project_build'
require'function_name'

local rem = require'remedybg'

rem.setup{}

vim.keymap.set("n", '<space><space>x', '<cmd>source%<cr>')
vim.keymap.set("n", '<space>x', ':.lua<cr>')
vim.keymap.set("v", '<space>x', ':lua<cr>')

vim.keymap.set("n", '<space>b', rem.start_debugging)
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
vim.keymap.set('n', '<leader>q', '<C-W>c', { desc = 'Focus window right' })
vim.keymap.set('n', '<leader>p', '<C-W>p', { desc = 'Focus window right' })
vim.keymap.set('n', '<leader>s', '<C-W>s', { desc = 'Focus window right' })
vim.keymap.set('n', '<leader>v', '<C-W>v', { desc = 'Focus window right' })

vim.keymap.set('n', '<leader>d', '<C-]>')
vim.keymap.set('n', '<leader>D', '<C-t>')
vim.keymap.set('n', '<leader>z', '<cmd>lua vim.diagnostic.setqflist()<cr>')

vim.keymap.set('n', 'gn', '<cmd>cnext<cr>')
vim.keymap.set('n', 'gp', '<cmd>cprev<cr>')

vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

if vim.fn.has('win32') or vim.fn.has('win64') then
    vim.keymap.set('n', '<F9>', '<cmd>!explorer .<cr><cr>')
end

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

vim.keymap.set('n', '<leader>y', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>r', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>t', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Lsp symbols' })
vim.keymap.set('n', '<leader>p', require'telescope'.extensions.projects.projects, { desc = 'Projects' })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-group', {clear = true} ),
	callback = function()
	    vim.highlight.on_yank()
	end,
    }
)
