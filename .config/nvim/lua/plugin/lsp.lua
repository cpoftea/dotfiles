vim.pack.add({
	{
		src = 'https://github.com/mason-org/mason.nvim',
		version = vim.version.range('2'),
	},
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/neovim/nvim-lspconfig',
})

require('mason').setup()
