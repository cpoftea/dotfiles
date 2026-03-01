return {
	cmd = {
		'docker', 'run', '--rm',
		'-i', '--volume', vim.fn.getcwd() .. ':/workspace',
		'--workdir', '/workspace',
		'lua-lsp-debian:latest',  -- real image
		'--logpath=/tmp/lua-ls.log',  -- writes logs to mounted /tmp
		'--log-level=1',  -- Verbose
	},
	filetypes = { 'lua' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
};
