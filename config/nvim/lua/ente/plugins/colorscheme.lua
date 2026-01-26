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
            -- Set the colorscheme
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- Gruvbox
    { "ellisonleao/gruvbox.nvim", lazy = true },
}
