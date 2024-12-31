return {
    {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function ()
			require'telescope'.setup{
				defaults = {
					file_ignore_patterns = { ".ccls-cache/%", ".zig-cache/%", ".git/%", ".zig-out/%", ".cache/*", ".git/*" },
				},
			}
		end,
    }
}