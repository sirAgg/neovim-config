vim.api.nvim_create_autocmd({'VimEnter', 'DirChanged'}, {
    desc = 'Loads project specific build commands',
    group = vim.api.nvim_create_augroup('build-command-group', {clear = true}),
    callback = function()
		if vim.fn.filereadable('.proj.vim') == 1 then
			vim.cmd('so .proj.vim')
		end
    end
})
