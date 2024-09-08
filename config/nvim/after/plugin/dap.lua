local dap = require('dap')
local dapui = require('dapui')
local widgets = require('dap.ui.widgets')

dapui.setup()

-- vim.keymap.set("n", "<F4>", dapui.toggle)
-- vim.keymap.set("n", "<F5>", dap.toggle_breakpoint)
-- vim.keymap.set("n", "<F9>", dap.continue)
--
-- vim.keymap.set("n", "<F1>", dap.step_over)
-- vim.keymap.set("n", "<F2>", dap.step_into)
-- vim.keymap.set("n", "<F3>", dap.step_out)
--
-- vim.keymap.set("n", "<Leader>dsc", dap.continue)
-- vim.keymap.set("n", "<Leader>dsv", dap.step_over)
-- vim.keymap.set("n", "<Leader>dsi", dap.step_into)
-- vim.keymap.set("n", "<Leader>dso", dap.step_out)
--
-- -- vim.keymap.set("n", "<Leader>dhh", require('dap.ui.variables').hover)
-- -- vim.keymap.set("v", "<Leader>dhv", require('dap.ui.variables').visual_hover)
--
-- vim.keymap.set("n", "<Leader>duh", dap.ui.widgets.hover)
-- vim.keymap.set("n", "<Leader>duf", widgets.centered_float(widgets.scopes))
--
-- vim.keymap.set("n", "<Leader>dro", dap.repl.open)
-- vim.keymap.set("n", "<Leader>drl", dap.repl.run_last)
--
-- vim.keymap.set("n", "<Leader>dbc", function()
-- 	dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
-- end)
-- vim.keymap.set("n", "<Leader>dbm", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set("n", "<Leader>dbt", dap.toggle_breakpoint)
--
-- vim.keymap.set("n", "<Leader>dc", dap.ui.variables.scopes)
-- vim.keymap.set("n", "<Leader>di", dapui.toggle)
vim.keymap.set('n', '<F4>', function() require('dapui').toggle() end)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
	function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/src/other/vscode-php-debug/out/phpDebug.js" }
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9003,
		pathMappings = {
			["/var/www/html"] = "${workspaceFolder}"
		}
	}
}
