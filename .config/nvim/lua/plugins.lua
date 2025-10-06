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
	'hrsh7th/nvim-cmp', -- Completion
	'hrsh7th/cmp-nvim-lsp',
	'ggandor/lightspeed.nvim',
	'L3MON4D3/LuaSnip',
	{
		'tzachar/cmp-tabnine',
		build = './install.sh',
		dependencies = 'hrsh7th/nvim-cmp',
	},

	'tpope/vim-fugitive',
	'saadparwaiz1/cmp_luasnip',
	'mhartington/formatter.nvim',
	'tjdevries/express_line.nvim',
	{
		'ojroques/vim-oscyank',
		branch = 'main',
	},
}
