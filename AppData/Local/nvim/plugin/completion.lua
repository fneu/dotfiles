MiniDeps.later(function()
    MiniDeps.add({
        source = "hrsh7th/nvim-cmp",
        depends = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-omni",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup()
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ["<C-p>"] = cmp.mapping.select_prev_item(),

            -- Scroll the documentation window [b]ack / [f]orward
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),

            -- If you prefer more traditional completion keymaps,
            -- you can uncomment the following lines
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ["<C-Space>"] = cmp.mapping.complete({}),

            -- Think of <c-l> as moving to the right of your snippet expansion.
            --  So if you have a snippet that's like:
            --  function $name($args)
            --    $body
            --  end
            --
            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer", keyword_length = 4 },
        },
        formatting = {
            format = require("lspkind").cmp_format(),
        },
    })

    -- disable slow completion in xml documents
    cmp.setup.filetype("xml", {
        enabled = false,
    })

    -- prevent slow completion blocking cmdline
    cmp.setup.cmdline(":", {
        enabled = false,
    })

    -- wiki.vim link completion
    cmp.setup.filetype("markdown", {
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer", keyword_length = 3 },
            { name = "omni" },
        },
    })
end)
