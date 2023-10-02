local flutter_commands = require('flutter-tools.commands')

function FlutterRunOrRestart()
    if not flutter_commands.is_running() then
	flutter_commands.run_command()
    else
	flutter_commands.restart()
    end
end

vim.keymap.set("n", "<leader>fr", FlutterRunOrRestart)
