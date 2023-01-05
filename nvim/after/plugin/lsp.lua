local ok, lsp = pcall(require, "lsp-zero")
if not ok then
    return
end

lsp.set_preferences(
    {
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = false, -- manually done below in on_attach
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = "local",
        sign_icons = {
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = ""
        }
    }
)

lsp.ensure_installed(
    {
        "marksman", -- markdown
        "pylsp", --python
        "omnisharp", --c_sharp
        "lemminx", --xml
        "sumneko_lua" --lua
    }
)

lsp.configure(
    "sumneko_lua",
    {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"}
                }
            }
        }
    }
)

lsp.configure(
    "omnisharp",
    {
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler
        }
    }
)

lsp.on_attach(
    function(client, bufnr)
        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(
                client,
                {
                    keymaps = {
                        next_signature = "<C-n>",
                        previous_signature = "<C-p>"
                    }
                }
            )
        end

        -- Lsp keymaps
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = bufnr, desc = "LSP: [R]e[n]ame"})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = bufnr, desc = "LSP: [C]ode [A]ction"})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr, desc = "LSP: [G]oto [D]efinition"})
        vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = bufnr, desc = "LSP: [G]oto [R]eferences"})
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer = bufnr, desc = "LSP: [G]oto [I]mplementation"})
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, {buffer = bufnr, desc = "LSP: Type [D]efinition"})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = bufnr, desc = "LSP: Hover Documentation"})
        vim.keymap.set(
            "n",
            "<C-k>",
            ":LspOverloadsSignature<CR>",
            {buffer = bufnr, silent = true, desc = "LSP: [P]arameter Documentation"}
        )
        vim.keymap.set(
            "i",
            "<C-k>",
            "<C-o>:LspOverloadsSignature<CR>",
            {buffer = bufnr, silent = true, desc = "LSP: [P]arameter Documentation"}
        )
        vim.keymap.set(
            "n",
            "<leader>wa",
            vim.lsp.buf.add_workspace_folder,
            {buffer = bufnr, desc = "LSP: [W]orkspace [A]dd folder"}
        )
        vim.keymap.set(
            "n",
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            {buffer = bufnr, desc = "LSP: [W]orkspace [R]emove folder"}
        )
        vim.keymap.set(
            "n",
            "<leader>wl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            {buffer = bufnr, desc = "LSP: [W]orkspace [L]ist folders"}
        )
        vim.keymap.set(
            {"n", "v"},
            "<leader>=",
            "<cmd>LspZeroFormat<cr>",
            {buffer = bufnr, desc = "LSP: format range or file"}
        )

        -- Diagnostic keymaps
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = bufnr, desc = "LSP: Previous [D]iagnostic"})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = bufnr, desc = "LSP: Next [D]iagnostic"})
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer = bufnr, desc = "LSP: show [E]rror"})
        vim.keymap.set(
            "n",
            "<leader>l",
            vim.diagnostic.setloclist,
            {buffer = bufnr, desc = "LSP: buffer diagnostics to [L]oclist"}
        )
        vim.keymap.set(
            "n",
            "<leader>q",
            vim.diagnostic.setqflist,
            {buffer = bufnr, desc = "LSP: all diagnostics to [Q]uickfix list"}
        )

        -- Telescope search keymaps
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {buffer = bufnr, desc = "LSP: [F]ind [R]eferences"})
        vim.keymap.set(
            "n",
            "<leader>fi",
            builtin.lsp_implementations,
            {buffer = bufnr, desc = "LSP: [F]ind [R]eferences"}
        )
        vim.keymap.set(
            "n",
            "<leader>fds",
            builtin.lsp_document_symbols,
            {buffer = bufnr, desc = "LSP: [F]ind [D]ocument [S]ymbols"}
        )
        vim.keymap.set(
            "n",
            "<leader>fws",
            builtin.lsp_workspace_symbols,
            {buffer = bufnr, desc = "LSP: [F]ind [W]orkspace [S]ymbols"}
        )
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {desc = "LSP: [F]ind [D]iagnostics"})
    end
)

-- remap some cmp mappings
local cmp = require("cmp")
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}
local luasnip = require("luasnip")
local cmp_mappings =
    lsp.defaults.cmp_mappings(
    {
        ["<C-d>"] = cmp.mapping.scroll_docs(5),
        ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        ["<C-f>"] = nil,
        ["<C-b>"] = nil,
        -- when menu is visible, navigate to next item
        -- else, expand or jump in snippet if possible
        -- else, when line is empty, insert a tab character
        -- else, activate completion
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                local col = vim.fn.col(".") - 1
                if cmp.visible() then
                    cmp.select_next_item(cmp_select_opts)
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                    fallback()
                else
                    cmp.complete()
                end
            end,
            {"i", "s"}
        ),
        -- when menu is visible, navigate to previous item on list
        -- else, iterate luasnip choices if present
        -- else, jump backwards in snippet if possible
        -- else, revert to default behavior
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item(cmp_select_opts)
                elseif luasnip.choice_active() then
                    luasnip.change_choice(1)
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            {"i", "s"}
        )
    }
)

lsp.setup_nvim_cmp(
    {
        mapping = cmp_mappings,
        sources = {
            {name = "path"},
            {name = "nvim_lsp", keyword_length = 3},
            {name = "luasnip", keyword_length = 2},
            {name = "buffer", keyword_length = 3}
        }
    }
)

lsp.setup()
