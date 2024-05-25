MiniDeps.add({
    source = "folke/todo-comments.nvim",
    depends = { "nvim-lua/plenary.nvim" },
})

MiniDeps.later(function()
    require("todo-comments").setup()

    vim.keymap.set("n", "ät", function()
        require("todo-comments").jump_next()
    end, { desc = "n[Ä]xt [T]odo comment" })

    vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
    end, { desc = "pr[Ö]vious [T]odo comment" })

    vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "[F]ind [T]odo-commends" })
end)
