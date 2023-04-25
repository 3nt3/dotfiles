local lsp = require("lsp-zero")

local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
})

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

-- we'll use rust-tools
lsp.skip_server_setup({ 'rust_analyzer' })

local cmp = require('cmp')
cmp.setup({
    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 1, trigger_characters = { '@' } },
    }, {
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 1, trigger_characters = { '@' } },
    })
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})


-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = cmp.mapping.conf

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.configure("tailwindcss", {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "rust" },
    init_options = {
        userLanguages = {
            rust = "html",
        },
    },
    settings = {
        includeLanguages = {
            rust = "html",
            ["*.rs"] = "html",
        },
    },

})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    require("lsp-inlayhints").on_attach(client, bufnr)
    lsp_status.on_attach(client)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)


vim.diagnostic.config({
    virtual_text = true,
})

lsp.setup()

local rust_lsp = lsp.build_options('rust_analyzer', {
    single_file_support = false,
    on_attach = function(client, bufnr)
    end,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all" },
            },
            rustfmt = {
                extraArgs = { "+nightly" },
            },
            procMacro = {
                enable = true,
            },
        },
    }
})

require('rust-tools').setup({ server = rust_lsp })


