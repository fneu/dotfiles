MiniDeps.later(function()
    MiniDeps.add({
        source = "folke/todo-comments.nvim",
        depends = { "nvim-lua/plenary.nvim" },
    })

    require("todo-comments").setup()

    vim.keymap.set("n", "ät", function()
        require("todo-comments").jump_next()
    end, { desc = "n[Ä]xt [T]odo comment" })

    vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
    end, { desc = "pr[Ö]vious [T]odo comment" })

    vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "[F]ind [T]odo-commends" })

    vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Enable todo-comments for text",
        group = vim.api.nvim_create_augroup("user.todo.text", { clear = true }),
        callback = function(ev)
            local config = require("todo-comments.config")
            local comments_only = string.match(ev.file, "%.md$") == nil and string.match(ev.file, "%.txt$") == nil
            config.options.highlight.comments_only = comments_only
        end,
    })
end)
