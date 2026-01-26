-- Utility Plugins Specification
return {
    -- Better escape
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        opts = {
            mappings = {
                -- i for insert
                i = {
                    j = {
                        -- These can all also be functions
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                },
                c = {
                    j = {
                        k = "<C-c>",
                        j = "<C-c>",
                    },
                },
                t = {
                    j = {
                        k = "<C-\\><C-n>",
                    },
                },
                v = {
                    j = {
                        k = "<Esc>",
                    },
                },
                s = {
                    j = {
                        k = "<Esc>",
                    },
                },
            },
            timeout = 200,
        },
    },

    -- Auto detect indentation
    {
        "tpope/vim-sleuth",
        event = { "BufReadPre", "BufNewFile" },
    },

    -- Surround motions
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            padding = true,
            sticky = true,
            toggler = {
                line = "gcc",
                block = "gbc",
            },
            opleader = {
                line = "gc",
                block = "gb",
            },
        },
    },

    -- Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
        },
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function()
            local harpoon = require("harpoon")
            return {
                { "<leader>a", function() harpoon:list():add() end,                         desc = "Harpoon: Add file" },
                { "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Toggle menu" },
                { "<C-h>",     function() harpoon:list():select(1) end,                     desc = "Harpoon: File 1" },
                { "<C-t>",     function() harpoon:list():select(2) end,                     desc = "Harpoon: File 2" },
                { "<C-n>",     function() harpoon:list():select(3) end,                     desc = "Harpoon: File 3" },
                { "<C-s>",     function() harpoon:list():select(4) end,                     desc = "Harpoon: File 4" },
            }
        end,
        config = function()
            require("harpoon"):setup()
        end,
    },

    -- Zen Mode
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
        },
        opts = {
            window = {
                width = 120,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                },
                tmux = { enabled = true },
                kitty = {
                    enabled = true,
                    font = "+4",
                },
            },
        },
    },

    -- Tailwind CSS colorizer
    {
        "themaxmarchuk/tailwindcss-colors.nvim",
        ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        config = function()
            require("tailwindcss-colors").setup()
        end,
    },

    -- Navigator (tmux/split navigation)
    {
        "numToStr/Navigator.nvim",
        keys = {
            { "<C-h>", "<cmd>NavigatorLeft<cr>",  desc = "Navigate Left" },
            { "<C-j>", "<cmd>NavigatorDown<cr>",  desc = "Navigate Down" },
            { "<C-k>", "<cmd>NavigatorUp<cr>",    desc = "Navigate Up" },
            { "<C-l>", "<cmd>NavigatorRight<cr>", desc = "Navigate Right" },
        },
        config = function()
            require("Navigator").setup()
        end,
    },

    -- Tmux navigation
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
        },
    },

    -- Better UI elements
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
    {
        "nvim-mini/mini.icons",
        lazy = true,
        opts = {},
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
    },
}
