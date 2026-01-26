-- Telescope Plugin Specification
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-dap.nvim",
    },
    cmd = "Telescope",
    keys = {
        { ";",               "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<C-p>",           "<cmd>Telescope git_files<cr>",  desc = "Find git files" },
        { "<leader><space>", "<cmd>Telescope buffers<cr>",    desc = "Find buffers" },
        {
            "<leader>sg",
            function()
                require("telescope.builtin").grep_string({
                    search = vim.fn.input("Grep > ")
                })
            end,
            desc = "Grep search"
        },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps" },
        { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search current word" },
        { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics" },
        { "<leader>sr", "<cmd>Telescope resume<cr>",      desc = "Resume last search" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Load extensions
        pcall(telescope.load_extension, "fzf")
        -- pcall(telescope.load_extension, "dap")
    end,
}
