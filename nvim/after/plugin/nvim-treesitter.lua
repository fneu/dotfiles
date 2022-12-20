local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

-- treesitter
configs.setup {
    ensure_installed = {"c_sharp", "python", "lua", "vim", "json", "markdown", "help"},
    highlight = {
        enable = true,

        -- as there is no treesitter syntax for xml available yet,
        -- this is necessary for xml folding
        additional_vim_regex_highlighting = {"xml",}
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
        },
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true
    }
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
