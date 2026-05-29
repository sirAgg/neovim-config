return {
    {
      'stevearc/oil.nvim',
      opts = {
	keymaps = {
		["<BS>"] = {"actions.parent", mode='n'}
	}
      },
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      --dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
