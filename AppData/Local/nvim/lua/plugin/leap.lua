return {
    -- jump movements like s..  dx..
    {
        "ggandor/leap.nvim",
        config = function(_, _)
            require "leap".add_default_mappings()
        end
    }
}
