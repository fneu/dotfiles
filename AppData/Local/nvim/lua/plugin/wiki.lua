vim.g.wiki_root = find_nextcloud() .. "\\Notizen"
vim.g.wiki_filetypes = { 'md' }
vim.g.wiki_link_extension = ""
vim.g.wiki_link_target_type = "wiki"
vim.g.wiki_mappings_use_defaults = "none"

vim.keymap.set('n', '<leader>wf',
    function()
        require"telescope.builtin".find_files({search_dirs={ find_nextcloud().."/Notizen" }})
    end,
    {desc="[W]iki [F]ind"})

vim.keymap.set('n', '<leader>wg',
    function()
        require"telescope.builtin".live_grep({search_dirs={ find_nextcloud().."/Notizen" }})
    end,
    {desc="[W]iki [G]rep"})

vim.g.wiki_mappings_global = {
    ["<plug>(wiki-index)"] = "<leader>ww",
    ["<plug>(wiki-open)"] = "<leader>wn",
    ["<plug>(wiki-journal)"] = "<leader>w<leader>w",
}
vim.g.wiki_mappings_local = {
    ["<plug>(wiki-page-delete)"] = "<leader>wd",
    ["<plug>(wiki-page-rename)"] = "<leader>wr",
    ["<plug>(wiki-page-toc)"] = "<leader>wc",
    ["<plug>(wiki-tag-list)"] = "<leader>wtl",
    ["<plug>(wiki-tag-reload)"] = "<leader>wtr",
    ["<plug>(wiki-tag-search)"] = "<leader>wtf",
    ["<plug>(wiki-link-next)"] = "<tab>",
    ["<plug>(wiki-link-follow)"] = "<cr>",
    ["<plug>(wiki-link-prev)"] = "<s-tab>",
    ["<plug>(wiki-link-return)"] = "<bs>",
    ["x_<plug>(wiki-link-toggle-visual)"] = "<cr>",
}
vim.g.wiki_mappings_local_journal = {
    ["<plug>(wiki-journal-prev)"] = "<c-n>",
    ["<plug>(wiki-journal-next)"] = "<c-p>",
}


return {
    {
        "lervag/wiki.vim",
    }
}
