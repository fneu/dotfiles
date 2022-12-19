-- treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"c_sharp", "python", "lua", "vim", "json", "markdown", "help"},
    highlight = {
        enable = true,
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
