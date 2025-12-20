return {
  {
    'saghen/blink.cmp',
    dependencies = {
	'rafamadriz/friendly-snippets',
	'L3MON4D3/LuaSnip',
    },
    version = 'v0.*',
    opts = {
      keymap = { preset = 'default' },
      snippets = { preset = 'luasnip' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { 
      "mireq/luasnip-snippets", 
    },
    config = function()
	local luasnip = require("luasnip")
	local mireq_utils = require("luasnip_snippets.common.snip_utils")

	mireq_utils.setup()

	luasnip.setup({
	    load_ft_func = mireq_utils.load_ft_func,
	    ft_func = mireq_utils.ft_func,

	    enable_autosnippets = true,
	    store_selection_keys = "<Tab>",
	})

        require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
    end
  },

}
