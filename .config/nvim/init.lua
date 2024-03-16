local o = vim.o
local opt = vim.opt

o.numberwidth = 2
o.number = true
o.relativenumber = true
o.signcolumn = 'yes:2'
o.statusline = '%<%f %h%m%r%=%{%Linter()%} %{%Diagnostic()%} %{FugitiveStatusline()} %y %-14.(%l,%c%V%) %P '

o.list = true
vim.opt.listchars = {
	tab = '\u{2192} ', -- →
	nbsp = '\u{25c7}', -- ◇
	-- eol = '↵',
	-- space = '·',
	trail = '\u{00b7}', -- ·
	extends = '\u{25b8}', -- ▸
	precedes = '\u{25c2}', -- ◂
}

o.backup = false
o.writebackup = false
o.swapfile = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.copilot_filetypes = {
	['*'] = false,
	typescriptreact = true,
	typescript = true,
	javascript = true,
	scss = true,
	css = true,
	json = true,
	lua = true,
	gitcommit = true,
}

vim.cmd([[
	highlight Comment cterm=none ctermfg=2
	highlight Type cterm=none ctermfg=6
	highlight Statement cterm=bold ctermfg=5
	highlight Identifier cterm=none ctermfg=none
	highlight Function cterm=none ctermfg=3
	highlight Boolean cterm=none ctermfg=4
	highlight Number cterm=none ctermfg=4
	highlight String cterm=none ctermfg=1
	highlight NormalFloat ctermfg=none ctermbg=none
	highlight FloatBorder ctermfg=none ctermbg=none
	highlight NonText ctermfg=8 ctermbg=none
	highlight SignColumn ctermbg=none
	highlight User1 cterm=reverse ctermfg=1
	highlight User2 cterm=reverse ctermfg=3
]])

-- Diff colors
vim.cmd([[
	highlight DiffAdd cterm=reverse ctermfg=4 ctermbg=NONE
	highlight DiffDelete cterm=reverse ctermfg=3 ctermbg=NONE
	highlight DiffText cterm=reverse ctermfg=4 ctermbg=NONE
	highlight DiffChange cterm=none ctermfg=none ctermbg=none
	highlight diffAdded ctermfg=4 cterm=none
	highlight diffRemoved ctermfg=3 cterm=none
]])

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

local builtin = require('telescope.builtin')

syntaxStack = require('syntaxStack')
vim.keymap.set('n', 'gm', ':lua syntaxStack()<CR>')

-- Emacs shell movement
vim.keymap.set('i', '<C-E>', '<ESC>A', { silent = true })
vim.keymap.set('i', '<C-A>', '<ESC>I', { silent = true })

-- Quit neovim
vim.keymap.set('n', '<C-Q>', '<CMD>q<CR>', { silent = true })

-- Select all
vim.keymap.set('n', '<C-A>', 'gg<S-V>G', { silent = true })

local cmp = require('cmp')
local ls = require('luasnip')

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		-- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-y>'] = cmp.config.disable,
		['<C-e>'] = cmp.mapping.abort(),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'cmp_tabnine' },
	}, {
		{ name = 'buffer' },
	}),
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = false;
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local utils = require('utils')
local opts = { noremap=true, }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local navic = require("nvim-navic")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	if client.server_capabilities["documentSymbolProvider"] then
		navic.attach(client, bufnr)
	end

	local newOpts = utils.merge(opts, { buffer = bufnr })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, newOpts)
	vim.keymap.set('n', '<leader>d', builtin.lsp_definitions, newOpts) -- vim.lsp.buf.definition, newOpts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, newOpts)
	vim.keymap.set('n', '<leader>i', builtin.lsp_implementations, newOpts) --vim.lsp.buf.implementation, newOpts)
	vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, newOpts)
	vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, newOpts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, newOpts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, newOpts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, newOpts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, newOpts)
	vim.keymap.set('n', '<leader>td', builtin.lsp_type_definitions, newOpts) --vim.lsp.buf.type_definition, newOpts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, newOpts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, newOpts)
	vim.keymap.set('n', '<leader>r', builtin.lsp_references, newOpts)
	vim.keymap.set('n', '<leader>tr', builtin.treesitter, newOpts)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, newOpts)
end

--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
local orig_nvim_open_win = vim.api.nvim_open_win
function vim.api.nvim_open_win(buffer, enter, config)
	config.border = 'single'
	return orig_nvim_open_win(buffer, enter, config)
end

require('java').setup()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 
	-- biome = {},
	tsserver = {},
	hls = {},
	jdtls = {},
}

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
}

require('lint').linters_by_ft = {
  javascript = {'eslint'},
  javascriptreact = {'eslint'},
  typescript = {'eslint'},
  typescriptreact = {'eslint'},
  scss = {'stylelint'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

local function get_diagnostic_count_by_severity(severity)
	local n = 0

	for i,v in pairs(vim.diagnostic.get(0, { severity = severity })) do
		n = n + 1
	end

	return n
end

local function diagnostic_to_statusline(severity, symbol, hl_group)
	local n = get_diagnostic_count_by_severity(severity)

	if n > 0 then
		return '%' .. hl_group .. '* ' .. symbol .. ' ' .. n .. ' %*'
	end

	return ''
end

vim.api.nvim_set_var('Diagnostic', function()
	local error = diagnostic_to_statusline(vim.diagnostic.severity.ERROR, '\u{f0159}', '1')
	local warning = diagnostic_to_statusline(vim.diagnostic.severity.WARN, '\u{f0028}', '2')

	return error .. warning
end)

vim.api.nvim_set_var('Linter', function()
  local linters = require("lint").get_running()
  if #linters == 0 then
      return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end)

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require('snippets')
--vim.api.nvim_create_autocmd('VimEnter', {
--	callback = function()
--		if vim.fn.argv(0) == '' then
--			builtin.find_files()
--		end
--	end,
--	once = true,
--})
require('formatter').setup({
	logging = true,
	filetype = {
		typescriptreact = {
			require('formatter.filetypes.typescriptreact').prettier,
		},
		typescript = {
			require('formatter.filetypes.typescript').prettier,
		},
		javascript = {
			require('formatter.filetypes.javascript').prettier,
		},
		scss = {
			require('formatter.defaults').prettier('scss'),
		},
	},
})
