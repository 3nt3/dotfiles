-- LSP Plugin Specification
return {
    -- Main LSP configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            { "j-hui/fidget.nvim", opts = {} }, -- LSP progress UI
            { "folke/neodev.nvim", opts = {} }, -- Neovim Lua development
        },
        config = function()
            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    source = "if_many",
                },
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Diagnostic signs
            local signs = {
                { name = "DiagnosticSignError", text = "✘" },
                { name = "DiagnosticSignWarn", text = "▲" },
                { name = "DiagnosticSignHint", text = "⚑" },
                { name = "DiagnosticSignInfo", text = "»" },
            }
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            -- LSP keybindings
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local opts = { buffer = event.buf, noremap = true, silent = true }
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- Stop eslint if attached
                    if client and client.name == "eslint" then
                        vim.cmd.LspStop("eslint")
                        return
                    end

                    local map = vim.keymap.set

                    -- Navigation
                    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
                    map("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                    map("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
                    map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

                    -- Hover
                    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
                    map("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

                    -- Workspace
                    map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbol" }))

                    -- Diagnostics
                    map("n", "<leader>vd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
                    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
                    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
                    map("n", "<leader>dl", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic list" }))

                    -- Actions
                    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
                    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                    map("n", "<leader>qf", function()
                        vim.lsp.buf.code_action({ only = { "quickfix" } })
                    end, vim.tbl_extend("force", opts, { desc = "Quickfix" }))

                    -- Formatting
                    if client and client.supports_method("textDocument/formatting") then
                        map("n", "<leader>f", function()
                            vim.lsp.buf.format({ async = true })
                        end, vim.tbl_extend("force", opts, { desc = "Format" }))
                    end

                    -- Highlight references under cursor
                    if client and client.supports_method("textDocument/documentHighlight") then
                        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormatOnSave", {}),
                pattern = { "*.lua", "*.rs", "*.js", "*.ts", "*.svelte", "*.c", "*.cpp" },
                callback = function(args)
                    local clients = vim.lsp.get_clients({ bufnr = args.buf })
                    for _, client in ipairs(clients) do
                        if client.supports_method("textDocument/formatting") then
                            vim.lsp.buf.format({
                                async = false,
                                timeout_ms = 10000,
                                bufnr = args.buf,
                            })
                            break
                        end
                    end
                end,
            })

            -- Setup capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- Setup Mason
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            -- Server configurations
            local servers = {
                ts_ls = {},
                rust_analyzer = {},
                tinymist = {
                    root_dir = function()
                        return vim.fn.getcwd()
                    end,
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            telemetry = { enable = false },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                        },
                    },
                },
                jdtls = {
                    cmd = { "jdtls" },
                    filetypes = { "java" },
                },
                html = {
                    settings = {
                        html = {
                            format = {
                                unformattedContentDelimiter = "<!-- noformat -->",
                            },
                        },
                    },
                },
                dartls = {},
            }

            -- Setup Mason LSPConfig
            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    -- Mason for installing LSP servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
    },
}
