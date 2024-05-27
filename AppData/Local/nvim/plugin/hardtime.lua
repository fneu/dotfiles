MiniDeps.later(function()
    MiniDeps.add({
        source = "m4xshen/hardtime.nvim",
        depends = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
    })

    require("hardtime").setup()
end)
