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
                { "<leader>1", function() harpoon:list():select(1) end,                     desc = "Harpoon: File 1" },
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

    -- Claude Code integration
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>cc", "<cmd>ClaudeCode<cr>",           desc = "Claude: Toggle" },
            { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Claude: Send selection" },
            { "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: Accept diff" },
            { "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Claude: Deny diff" },
        },
    },

    -- File explorer as a buffer
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false, -- replaces netrw for directory buffers
        keys = {
            { "-",          "<cmd>Oil<cr>", desc = "Open parent directory" },
            { "<leader>pv", "<cmd>Oil<cr>", desc = "Open file explorer" },
        },
        opts = {
            default_file_explorer = true,
            view_options = { show_hidden = true },
        },
    },

    -- File tree sidebar (left; Claude pane lives on the right)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "<leader>e", "<cmd>Neotree toggle reveal<cr>",          desc = "Neo-tree: toggle file tree" },
            { "<leader>E", "<cmd>Neotree toggle source=git_status<cr>", desc = "Neo-tree: git status" },
        },
        opts = {
            close_if_last_window = true,
            window = {
                position = "left",
                width = 32,
            },
            filesystem = {
                hijack_netrw_behavior = "disabled", -- oil handles directory buffers
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        },
    },

    -- Git diff / history viewer
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
        keys = {
            { "<leader>gv", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: open" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history" },
            { "<leader>gq", "<cmd>DiffviewClose<cr>",         desc = "Diffview: close" },
        },
    },

    -- Diagnostics / quickfix lists
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Trouble: workspace diagnostics" },
            { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: buffer diagnostics" },
            { "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>",           desc = "Trouble: references" },
            { "<leader>tq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Trouble: quickfix" },
        },
    },
}
