-- Git and Language-specific Plugins
return {
    -- Git integration
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
            { "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git blame" },
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
        },
    },

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
                map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
                map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Stage hunk" })
                map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "Reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
                map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end,
        },
    },

    -- GitHub Copilot
    {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
        end,
    },

    -- LaTeX support
    {
        "lervag/vimtex",
        ft = { "tex", "latex" },
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
        end,
    },

    -- Typst support
    {
        "kaarmu/typst.vim",
        ft = { "typst" },
    },

    -- Flutter tools
    {
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        opts = {
            lsp = {
                color = {
                    enabled = true,
                    background = true,
                    foreground = false,
                    virtual_text = true,
                    virtual_text_str = "■",
                },
            },
        },
    },

    -- Jupyter/IPython support
    {
        "dccsillag/magma-nvim",
        build = ":UpdateRemotePlugins",
        ft = { "python", "jupyter" },
        keys = {
            { "<LocalLeader>r",  ":MagmaEvaluateOperator<CR>",    expr = true,   silent = true,            desc = "Evaluate operator" },
            { "<LocalLeader>rr", ":MagmaEvaluateLine<CR>",        silent = true, desc = "Evaluate line" },
            { "<LocalLeader>r",  ":<C-u>MagmaEvaluateVisual<CR>", mode = "x",    silent = true,            desc = "Evaluate visual" },
            { "<LocalLeader>rc", ":MagmaReevaluateCell<CR>",      silent = true, desc = "Re-evaluate cell" },
            { "<LocalLeader>rd", ":MagmaDelete<CR>",              silent = true, desc = "Delete cell" },
            { "<LocalLeader>ro", ":MagmaShowOutput<CR>",          silent = true, desc = "Show output" },
        },
        config = function()
            vim.g.magma_automatically_open_output = false
            vim.g.magma_image_provider = "kitty"
        end,
    },

    -- Formatter
    {
        "mhartington/formatter.nvim",
        cmd = { "Format", "FormatWrite" },
        config = function()
            require("formatter").setup({
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    python = {
                        require("formatter.filetypes.python").black,
                    },
                    javascript = {
                        require("formatter.filetypes.javascript").prettier,
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").prettier,
                    },
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    },
                },
            })
        end,
    },
}
