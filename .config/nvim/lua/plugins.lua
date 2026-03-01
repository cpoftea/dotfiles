return {
	'github/copilot.vim',
	'mason-org/mason.nvim',
	{
		'mason-org/mason-lspconfig.nvim',
		opts = {},
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'neovim/nvim-lspconfig',
		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end
	},
	{
		'utilyre/barbecue.nvim',
		name = 'barbecue',
		version = '*',
		dependencies = {
			'SmiteshP/nvim-navic',
			'nvim-tree/nvim-web-devicons',
		},
		opts = {},
	},
	'nvim-lua/plenary.nvim',
	{
		'nvim-telescope/telescope.nvim',
		version = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
		}
	},
	'mfussenegger/nvim-lint',
	{
		'saghen/blink.cmp',
		version = '1.*',
		opts = {
			keymap = { preset = 'default' },
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},
	'ggandor/lightspeed.nvim',
	'L3MON4D3/LuaSnip',
	'tpope/vim-fugitive',
	'mhartington/formatter.nvim',
	'tjdevries/express_line.nvim',
	{
		'ojroques/vim-oscyank',
		branch = 'main',
	},
}
