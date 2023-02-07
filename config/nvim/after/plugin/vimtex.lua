-- set latexmk options
vim.g.vimtex_compiler_latexmk = {
  build_dir = 'build',
  continuous = 1,
  executable = 'latexmk',
  options = {
	'-pdf',
	'-pvc',
	'-lualatex',
	'-verbose',
	'-file-line-error',
	'-synctex=1',
	'-interaction=nonstopmode',
  },
}
