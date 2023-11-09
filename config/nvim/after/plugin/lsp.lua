local lsp = require("lsp-zero")

lsp.preset("recommended")

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'rust_analyzer' },
    handlers = {
        lsp.default_setup,
    },
})

lsp.configure('dartls')

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

-- configure yaml ls
lsp.configure('yamlls', {
    settings = {
        yaml = {
            keyOrdering = false
        }
    }
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, opts)

    local function quickfix()
        vim.lsp.buf.code_action({
            only = { "quickfix" },
        })
    end

    vim.keymap.set('n', '<leader>qf', quickfix, opts)

    -- Open code actions using the default lsp UI, if you want to change this please see the plugins above
end)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        -- if you have a working setup with null-ls
        -- you can specify filetypes it can format.
        ['null-ls'] = { 'javascript', 'typescript', 'svelte' },
    }
})

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})




lsp.setup()

local null_ls = require("null-ls")
local prettier = require("prettier")

prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
})

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.prettier,
    },
})

vim.diagnostic.config({
    virtual_text = true,
})


cmp.setup({
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip",  trigger_characters = { "@" }, group_index = 1 },
        { name = "buffer",   group_index = 2 },
    })
})

require("luasnip.loaders.from_vscode").lazy_load()

require("flutter-tools").setup {} -- use defaults

-- jupyter

vim.api.nvim_set_keymap('n', '<LocalLeader>r', ':MagmaEvaluateOperator<CR>', { silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>rr', ':MagmaEvaluateLine<CR>', { silent = true })
vim.api.nvim_set_keymap('x', '<LocalLeader>r', ':<C-u>MagmaEvaluateVisual<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>rc', ':MagmaReevaluateCell<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>rd', ':MagmaDelete<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>ro', ':MagmaShowOutput<CR>', { silent = true })

-- Settings
vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "kitty"
