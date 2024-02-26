require('rose-pine').setup({
  disable_background = false
})

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = true
})

function ColorMyPencils(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
end

ColorMyPencils()
