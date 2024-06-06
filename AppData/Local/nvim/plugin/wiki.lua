MiniDeps.later(function()
    MiniDeps.add("lervag/wiki.vim")

    local wiki_root = vim.fn.expand("~/Nextcloud/Notizen")
    vim.g.wiki_root = wiki_root

    vim.g.wiki_filetypes = { "md" }
    vim.g.wiki_link_extension = ""
    vim.g.wiki_link_target_type = "wiki"
    vim.g.wiki_mappings_use_defaults = "none"

    vim.keymap.set("n", "<leader>wf", "<plug>(wiki-pages)", { desc = "[W]iki [F]ind" })

    vim.keymap.set("n", "<leader>wg", function()
        require("telescope.builtin").live_grep({ search_dirs = { wiki_root } })
    end, { desc = "[W]iki [G]rep" })

    vim.g.wiki_mappings_global = {
        ["<plug>(wiki-index)"] = "<leader>ww",
        ["<plug>(wiki-open)"] = "<leader>wn",
    }
    vim.g.wiki_mappings_local = {
        ["<plug>(wiki-page-delete)"] = "<leader>wd",
        ["<plug>(wiki-page-rename)"] = "<leader>wr",
        ["<plug>(wiki-tags)"] = "<leader>wt",
        ["<plug>(wiki-link-add)"] = "<leader>wa",
        ["<plug>(wiki-link-next)"] = "<tab>",
        ["<plug>(wiki-link-follow)"] = "<cr>",
        ["<plug>(wiki-link-prev)"] = "<s-tab>",
        ["<plug>(wiki-link-return)"] = "<bs>",
        ["x_<plug>(wiki-link-toggle-visual)"] = "<cr>",
    }
end)
