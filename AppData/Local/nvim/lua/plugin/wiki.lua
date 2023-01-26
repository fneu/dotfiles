vim.g.wiki_root = find_nextcloud() .. "\\Notizen"
vim.g.wiki_filetypes = { 'md' }
vim.g.wiki_link_extension = ""
vim.g.wiki_link_target_type = "wiki"
vim.g.wiki_mappings_local = {
    ["<plug>(wiki-link-toggle)"] = "",
    ["<plug>(wiki-graph-find-backlinks)"] = "",
    ["<plug>(wiki-graph-related) "] = "",
    ["<plug>(wiki-graph-check-links)"] = "",
    ["<plug>(wiki-graph-check-links-g)"] = "",
    ["<plug>(wiki-graph-in)"] = "",
    ["<plug>(wiki-graph-out)"] = ""
}

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

return {
    {
        "lervag/wiki.vim",
    }
}
