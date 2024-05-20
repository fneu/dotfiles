return {
    -- this supports block comments that mini.comment doesn't
    -- this supports i.e. word comments that mini.comment doesn't,
    -- useful for commenting out parameters with `gcaa` etc
    -- mini.comment includes a `gc` textobject that this doesn't
    {
        "numToStr/Comment.nvim",
        config = function(_, _)
            require("Comment").setup()
        end
    }
}
