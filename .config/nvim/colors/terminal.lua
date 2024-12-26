local api = vim.api
local opt = vim.opt

local groupId = api.nvim_create_augroup('ColorSchemeTerminal', {
	clear = true,
})

local saved = {
	termguicolors = opt.termguicolors:get(),
}

api.nvim_create_autocmd({ 'ColorScheme' }, {
	group = groupId,
	callback = function(ev)
		opt.termguicolors = false
	end,
})

api.nvim_create_autocmd({ 'ColorSchemePre' }, {
	group = groupId,
	callback = function(ev)
		opt.termguicolors = saved.termguicolors
		api.nvim_del_augroup_by_id(groupId)
	end,
})
