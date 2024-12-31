return {
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = 'rafamadriz/friendly-snippets',

      version = 'v0.*',
      opts = {
	keymap = { preset = 'default' },

	appearance = {
	  -- Sets the fallback highlight groups to nvim-cmp's highlight groups
	  -- Useful for when your theme doesn't support blink.cmp
	  -- will be removed in a future release
	  use_nvim_cmp_as_default = true,
	  -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	  -- Adjusts spacing to ensure icons are aligned
	  nerd_font_variant = 'mono'
	},

	-- experimental signature help support
	signature = { enabled = true }
      },
      -- allows extending the providers array elsewhere in your config
      -- without having to redefine it
      opts_extend = { "sources.default" }
    },
}