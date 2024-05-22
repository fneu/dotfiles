MiniDeps.add{
    source = "m4xshen/hardtime.nvim",
    depends = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    }
}

MiniDeps.later(function()
    require("hardtime").setup()
end)
