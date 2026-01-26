-- Neovim Options Configuration

local opt = vim.opt

-- UI
opt.guicursor = ""
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true
opt.termguicolors = true
opt.pumheight = 10 -- Popup menu height

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Text Wrapping
opt.wrap = false
opt.linebreak = true

-- File Management
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.writebackup = false

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300
opt.lazyredraw = false

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-- Misc
opt.isfname:append("@-@")
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a"
opt.showmode = false

-- Global Settings
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Plugin-specific settings
vim.g.sleuth_tex_defaults = "tabstop=4"
