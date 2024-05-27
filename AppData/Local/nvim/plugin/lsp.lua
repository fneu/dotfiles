MiniDeps.later(function()
    MiniDeps.add({
        source = "neovim/nvim-lspconfig",
        depends = {
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "j-hui/fidget.nvim",
            "Hoffs/omnisharp-extended-lsp.nvim",
            "nvim-telescope/telescope.nvim",
        },
    })

    require("neodev").setup({})
    require("fidget").setup({})
    require("mason").setup({})

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if pcall(require, "cmp_nvim_lsp") then
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    end

    -- add language servers here
    local servers = {
        -- TODO: manually roll back version to v1.39.8
        -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2574
        omnisharp = {
            settings = {
                Cs = {
                    enable_editorconfig_support = true,
                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    enable_ms_build_load_projects_on_demand = false,
                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    enable_roslyn_analyzers = false,
                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    organize_imports_on_format = true,
                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    enable_import_completion = true,
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    sdk_include_prereleases = true,
                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    analyze_open_documents_only = false,
                },
            },
        },
        lua_ls = {
            settings = {
                Lua = {
                    hint = {
                        enable = true,
                    },
                },
            },
        },
    }

    -- add other tools here
    local ensure_installed = vim.tbl_keys(servers or {})

    -- Filter out omnisharp without a version specified
    -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2574
    ensure_installed = vim.tbl_filter(function(item)
        return item ~= "omnisharp"
    end, ensure_installed)

    vim.list_extend(ensure_installed, {
        "stylua",
        { "omnisharp", version = "v1.39.8" },
        "isort",
        "black",
        "csharpier",
    })

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(args)
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })

            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = args.buf, silent = true, desc = "LSP: " .. desc })
            end

            if filetype == "cs" then
                map("gd", ":lua require('omnisharp_extended').telescope_lsp_definitions()<cr>", "[G]oto [D]efinition")
                map("gr", ":lua require('omnisharp_extended').telescope_lsp_references()<cr>", "[G]oto [R]eferences")
                map(
                    "gI",
                    ":lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>",
                    "[G]oto [I]mplementation"
                )
                map("gD", ":lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", "Type [D]efinition")
            else
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                map("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
            end
            map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            map("K", vim.lsp.buf.hover, "Hover Documentation")

            -- Highlight references of the word under cursor if it rests there for a while.
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = args.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    buffer = args.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd("LspDetach", {
                    group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                    end,
                })
            end

            -- enable inlay hints
            if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                map("<leader>th", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                    print("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled({}) and "enabled" or "disabled"))
                end, "[T]oggle Inlay [H]ints")
            else
                map("<leader>th", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                    print("Inlay hints are not supported!")
                end, "[T]oggle Inlay [H]ints")
            end
        end,
    })

    -- This is necessary to reliably have the lsp start on the initial buffer.
    -- Since this is lazy loaded it will start after the initial autocmd
    -- that triggers nvim-lspconfig to attach the lsp
    vim.api.nvim_exec_autocmds("FileType", {})
end)
