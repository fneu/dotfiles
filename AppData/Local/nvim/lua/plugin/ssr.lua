return {
    -- structural search and replace <leader>sr,
    {
        "cshuaimin/ssr.nvim",
        config = function(_, _)
            vim.keymap.set(
                {"n", "x"},
                "<leader>sr",
                function()
                    require "ssr".open()
                end,
                {desc = "[S]tructural [S]earch and [R]eplace"}
            )
        end
    }
}
