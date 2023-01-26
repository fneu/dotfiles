return {
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                keymaps = {
                    ["gd"]={
                        callback = function()
                            require"oil".set_columns({{"mtime", format="%Y-%m-%d %H:%M"}, "icon"})  -- set new layout
                            vim.cmd.edit({ bang = true })  -- reload buffer, otherwise the layout might not be applied
                            vim.wait(100)  -- wait, otherwise the next step might be overwritten
                            vim.cmd([[:sort /^\S\+\s\zs.\+/ r]])  -- sort lines starting at second wort, which is the timestamp
                        end,
                        desc="sort by [D]ate",
                        nowait=true},
                    ["gD"]={
                        callback = function()
                            require"oil".set_columns({{"mtime", format="%Y-%m-%d %H:%M"}, "icon"})
                            vim.cmd.edit({ bang = true })
                            vim.wait(100)
                            vim.cmd([[:sort! /^\S\+\s\zs.\+/ r]])
                        end,
                        desc="sort by [D]ate (reversed)",
                        nowait=true},
                    ["gn"]={
                        callback = function()
                            require"oil".set_columns({"icon"})
                            vim.cmd.edit({ bang = true })
                            vim.wait(100)
                            vim.cmd([[:sort /^\S\+\s\S\+\s\+\zs.\+/ r]])  -- sort lines starting at third word, which is the filename after the icon
                        end,
                        desc="sort by [N]ame",
                        nowait=true},
                    ["gN"]={
                        callback = function()
                            require"oil".set_columns({"icon"})
                            vim.cmd.edit({ bang = true })
                            vim.wait(100)
                            vim.cmd([[:sort! /^\S\+\s\S\+\s\+\zs.\+/ r]])
                        end,
                        desc="sort by [N]ame (reversed)",
                        nowait=true},
                }
            })
            vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
            vim.keymap.set("n", "_", function() require("oil").open(".") end, { desc = "Open parent directory" })
        end
    }
}
