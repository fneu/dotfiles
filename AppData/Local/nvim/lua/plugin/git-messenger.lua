return {
    {
        "rhysd/git-messenger.vim",
        config = function(_, _)
            vim.g.git_messenger_no_default_mappings = true

            vim.cmd("let g:git_messenger_floating_win_opts = { 'border': 'single',}")
            vim.keymap.set("n", "<leader>gk", "<Plug>(git-messenger)", {desc = "[G]it [K]"})

            -- set in telescope.lua:
            -- <leader>gb -> search/checkout brances
            -- <leader>gs -> search/apply stashes (stash in fugitive via czz)
        end
    }
}
