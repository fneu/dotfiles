vim.g.scratch_autohide = false

return {
    {
        "mtth/scratch.vim",
        config = function(_, _)
            vim.keymap.set("n", "gs", ":Scratch<cr>", {desc = "Open [S]cratch buffer"})
            vim.keymap.set("n", "gS", ":Scratch!<cr>", {desc = "Open and clear [S]cratch buffer"})
        end
    }
}
