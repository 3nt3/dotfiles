-- Colorscheme Plugin Specification
return {
    -- Rose Pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "main", -- auto, main, moon, or dawn
                dark_variant = "main",
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
            })
        end,
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    telescope = {
                        enabled = true,
                    },
                    mason = true,
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                },
            })
        end,
    },

    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = false, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                inverse = true,      -- invert background for search, diffs, statuslines and errors
                contrast = "medium", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    -- inverse diffs paint changed lines solid yellow; use muted dark backgrounds instead
                    DiffAdd    = { bg = "#2a3b2a", reverse = false },
                    DiffDelete = { bg = "#3b2424", fg = "#5a3a3a", reverse = false },
                    DiffChange = { bg = "#2b3040", reverse = false },
                    DiffText   = { bg = "#46506b", bold = true, reverse = false },
                },
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd("colorscheme gruvbox")
        end
    },
}
