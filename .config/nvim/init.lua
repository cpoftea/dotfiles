local o = vim.o
local opt = vim.opt

o.numberwidth = 2
o.number = true
o.relativenumber = true
o.signcolumn = 'yes:2'
o.statusline = '%<%f %h%m%r%=%{%Linter()%} %{%Diagnostic()%} %{FugitiveStatusline()} %y %-14.(%l,%c%V%) %P '
o.hidden = true
o.completeopt = 'noselect'

o.list = true
opt.listchars = {
	tab = '\u{2192} ', -- →
	nbsp = '\u{25c7}', -- ◇
	-- eol = '↵',
	-- space = '·',
	trail = '\u{00b7}', -- ·
	extends = '\u{25b8}', -- ▸
	precedes = '\u{25c2}', -- ◂
}

vim.cmd.colorscheme('terminal')

o.backup = false
o.writebackup = false
o.swapfile = false
o.winborder = 'single'
o.autoread = true

vim.g.copilot_filetypes = {
	['*'] = false,
	typescriptreact = true,
	typescript = true,
	javascript = true,
	scss = true,
	cs = true,
	css = true,
	json = true,
	lua = true,
	gitcommit = true,
}

vim.treesitter.language.register('typescript', { 'tsx', 'typescriptreact' })

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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.lazy')

local builtin = require('telescope.builtin')

syntaxStack = require('syntaxStack')
vim.keymap.set('n', 'gm', ':lua syntaxStack()<CR>')

-- Emacs shell movement
vim.keymap.set('i', '<C-E>', '<ESC>A', { silent = true })
vim.keymap.set('i', '<M-A>', '<ESC>I', { silent = true })

-- Quit neovim
vim.keymap.set('n', '<C-Q>', '<CMD>q<CR>', { silent = true })

-- Select all
vim.keymap.set('n', '<C-A>', 'gg<S-V>G', { silent = true })

-- ANSI OSC52 clipboard
vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

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

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
-- 	max_lines = 1000;
-- 	max_num_results = 20;
-- 	sort = true;
-- 	run_on_every_keystroke = true;
-- 	snippet_placeholder = '..';
-- 	ignored_file_types = { -- default is not to ignore
-- 		-- uncomment to ignore in lua:
-- 		-- lua = true
-- 	};
-- 	show_prediction_strength = false;
-- })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local utils = require('utils')
local opts = { noremap=true, }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local navic = require("nvim-navic")

-- Use an LspAttach event to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr = ev.buf

		-- Enable completion triggered by <c-x><c-o>
		-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end

		if client.server_capabilities.documentSymbolProvider then
			require('nvim-navic').attach(client, bufnr)
		end

		local newOpts = utils.merge(opts, { buffer = bufnr })

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, newOpts)
		vim.keymap.set('n', '<leader>d', builtin.lsp_definitions, newOpts) -- vim.lsp.buf.definition, newOpts)
		vim.keymap.set('n', '<leader>i', builtin.lsp_implementations, newOpts) --vim.lsp.buf.implementation, newOpts)
		vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, newOpts)
		vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, newOpts)
		vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, newOpts)
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
	end,
})

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
require('mason-lspconfig').setup({
	ensure_installed = {
		'ts_ls',
	},
})

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

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
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

vim.cmd([[
	if (!has('clipboard_working'))
		" In the event that the clipboard isn't working, it's quite likely that
		" the + and * registers will not be distinct from the unnamed register. In
		" this case, a:event.regname will always be '' (empty string). However, it
		" can be the case that `has('clipboard_working')` is false, yet `+` is
		" still distinct, so we want to check them all.
		let s:VimOSCYankPostRegisters = ['', '+', '*']
		function! s:VimOSCYankPostCallback(event)
			if a:event.operator == 'y' && index(s:VimOSCYankPostRegisters, a:event.regname) != -1
				call OSCYankRegister(a:event.regname)
			endif
		endfunction
		augroup VimOSCYankPost
			autocmd!
			autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
		augroup END
	endif
]])
