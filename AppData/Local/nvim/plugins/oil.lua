MiniDeps.add("stevearc/oil.nvim")

require("oil").setup{
    columns = { "icon" },
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "_", ":e .<CR>", { desc = "Open current root directory" })
