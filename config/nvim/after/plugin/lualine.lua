local lualine = require('lualine')

-- Mode symbols not exposed as options, so modify internals
local mode_map = {
	n     = '∙',
	i     = '|',
	ic    = '|',
	ix    = '|',
	v     = '→',
	V     = '↔',
	[''] = '↕',
	c     = '$'
}
for k, v in pairs(mode_map) do
	require('lualine.utils.mode').map[k] = v
end

local lsp_status = require('lsp-status')
lsp_status.config({
	indicator_info = 'i',
	indicator_hint = '?',
	indicator_ok = '',
	status_symbol = '',
})
lsp_status.register_progress()

require('lualine').setup({
	options = {
		theme = 'auto',
	},
	sections = {
		lualine_y = { "require('lsp-status').status()" }
	}
})
