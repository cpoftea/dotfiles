vim.pack.add({
	'https://github.com/github/copilot.vim',
})

-- build nvim-treesitter
vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter',
})

require('nvim-treesitter.install').update()

--

vim.pack.add({
	'https://github.com/SmiteshP/nvim-navic',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/utilyre/barbecue.nvim',
})

--

vim.pack.add({
	'https://github.com/nvim-lua/plenary.nvim',
	{
		src = 'https://github.com/nvim-telescope/telescope.nvim',
		version = vim.version.range('0.2'),
	},
})

--

vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

vim.pack.add({
	'https://github.com/ggandor/lightspeed.nvim',
	'https://github.com/L3MON4D3/LuaSnip',
	'https://github.com/tpope/vim-fugitive',
	'https://github.com/mhartington/formatter.nvim',
	'https://github.com/tjdevries/express_line.nvim',
	{
		src = 'https://github.com/ojroques/vim-oscyank',
		branch = 'main',
	},
})

vim.pack.add({ 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' })

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = false } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" }
})
