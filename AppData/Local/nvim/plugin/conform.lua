MiniDeps.later(function()
    MiniDeps.add({
        source = "stevearc/conform.nvim",
    })

    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            cs = { "csharpier" },
            haskell = { "ormolu" },
        },
    })

    -- format on save, but not csharp and no lsp fallback
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.py", "*.hs" },
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })

    -- gq
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end)
