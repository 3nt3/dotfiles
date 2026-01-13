-- Modern Neovim LSP Configuration (0.10+)

-- Setup capabilities for nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
    'force',
    capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- Setup Mason
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'ts_ls', 'rust_analyzer', 'tinymist', 'lua_ls', 'yamlls', 'jdtls', 'html', 'dartls' },
    handlers = {
        -- Default handler for all servers
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- Custom handler for tinymist
        tinymist = function()
            require('lspconfig').tinymist.setup({
                capabilities = capabilities,
                root_dir = function(filename, bufnr)
                    return vim.fn.getcwd()
                end,
            })
        end,

        -- Custom handler for lua_ls
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
        end,

        -- Custom handler for yamlls
        yamlls = function()
            require('lspconfig').yamlls.setup({
                capabilities = capabilities,
                settings = {
                    yaml = {
                        keyOrdering = false
                    }
                }
            })
        end,

        -- Custom handler for jdtls
        jdtls = function()
            require('lspconfig').jdtls.setup({
                capabilities = capabilities,
                cmd = { "jdtls" },
                filetypes = { "java" }
            })
        end,

        -- Custom handler for html
        html = function()
            require('lspconfig').html.setup({
                capabilities = capabilities,
                settings = {
                    html = {
                        format = {
                            unformattedContentDelimiter = "<!-- noformat -->",
                        }
                    }
                }
            })
        end,

        -- Custom handler for dartls
        dartls = function()
            require('lspconfig').dartls.setup({
                capabilities = capabilities,
            })
        end,
    },
})

-- LSP Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Stop eslint if attached
        if client and client.name == "eslint" then
            vim.cmd.LspStop('eslint')
            return
        end

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Workspace
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

        -- Diagnostics
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- Actions
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Formatting
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        -- Quickfix
        vim.keymap.set('n', '<leader>qf', function()
            vim.lsp.buf.code_action({
                only = { "quickfix" },
            })
        end, opts)
    end
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.lua', '*.rs', '*.js', '*.ts', '*.svelte', '*.c', '*.cpp' },
    callback = function(args)
        local client = vim.lsp.get_clients({ bufnr = args.buf })[1]
        if client then
            vim.lsp.buf.format({
                async = false,
                timeout_ms = 10000,
                bufnr = args.buf,
            })
        end
    end,
})

-- Diagnostic signs
vim.fn.sign_define('DiagnosticSignError', { text = '✘', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '▲', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint', { text = '⚑', texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '»', texthl = 'DiagnosticSignInfo' })

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

-- nvim-cmp setup
local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Disable Tab/Shift-Tab for copilot compatibility
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip", trigger_characters = { "@" }, group_index = 1 },
        { name = "buffer", group_index = 2 },
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Flutter tools
require("flutter-tools").setup({})

-- Jupyter/Magma keybindings
vim.keymap.set('n', '<LocalLeader>r', ':MagmaEvaluateOperator<CR>', { silent = true, expr = true })
vim.keymap.set('n', '<LocalLeader>rr', ':MagmaEvaluateLine<CR>', { silent = true })
vim.keymap.set('x', '<LocalLeader>r', ':<C-u>MagmaEvaluateVisual<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>rc', ':MagmaReevaluateCell<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>rd', ':MagmaDelete<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>ro', ':MagmaShowOutput<CR>', { silent = true })

-- Magma settings
vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "kitty"
