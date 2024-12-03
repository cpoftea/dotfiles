return {
	'github/copilot.vim',
	{
		'jackMort/ChatGPT.nvim',
		dependencies = {
			'MunifTanjim/nui.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'nvim-java/nvim-java',
		dependencies = {
			'nvim-java/nvim-java-refactor',
			'nvim-java/lua-async-await',
			'nvim-java/nvim-java-core',
			'nvim-java/nvim-java-test',
			'nvim-java/nvim-java-dap',
			'MunifTanjim/nui.nvim',
			'neovim/nvim-lspconfig',
			'mfussenegger/nvim-dap',
			{
				'williamboman/mason.nvim',
				opts = {
					registries = {
						'github:nvim-java/mason-registry',
						'github:mason-org/mason-registry',
					},
				},
			},
		},
	},
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
	},
	{ -- Collection of configurations for the built-in LSP client
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
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
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		}
	},
	'mfussenegger/nvim-lint',
	'wakatime/vim-wakatime',
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
