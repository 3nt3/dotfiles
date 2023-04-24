require('rose-pine').setup({
    disable_background = false
})

function ColorMyPencils(color)
	-- color = color or "rose-pine"
	color = color or "seoul256"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()
