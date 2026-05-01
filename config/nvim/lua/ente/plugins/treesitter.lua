-- Treesitter Plugin Specification
-- return {
--     "nvim-treesitter/nvim-treesitter",
--     branch = "main",
--     build = ":TSUpdate",
--     event = { "BufReadPost", "BufNewFile" },
--     cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
--     config = function(_, opts)
--         require("nvim-treesitter").setup(opts)
--     end,
--     opts = {
--         ensure_installed = {
--             "bash", "c", "cpp", "css", "dart", "html", "java",
--             "javascript", "json", "lua", "markdown", "markdown_inline",
--             "python", "rust", "tsx", "typescript", "vim", "vimdoc", "yaml", "svelte", "go"
--         },
--         sync_install = false,
--         auto_install = true,
--         highlight = {
--             enable = true,
--             additional_vim_regex_highlighting = false,
--         },
--         indent = {
--             enable = true,
--         },
--         incremental_selection = {
--             enable = true,
--             keymaps = {
--                 init_selection = "<C-space>",
--                 node_incremental = "<C-space>",
--                 scope_incremental = false,
--                 node_decremental = "<bs>",
--             },
--         },
--     },
-- }
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
    end,
    opts = {
        ensure_installed = {
            "bash", "c", "cpp", "css", "dart", "html", "java",
            "javascript", "json", "lua", "markdown", "markdown_inline",
            "python", "rust", "tsx", "typescript", "vim", "vimdoc", "yaml", "svelte", "go"
        },
    }
}
