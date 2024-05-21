MiniDeps.add{
    source = "stevearc/oil.nvim",
    depends = {
        "nvim-tree/nvim-web-devicons",
    }
}

MiniDeps.now(function()
    require("oil").setup{
        columns = { "icon" },
        view_options = {
            show_hidden = true,
        },
    }

    vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "_", ":e .<CR>", { desc = "Open current root directory" })
end)
