MiniDeps.later(function()
    MiniDeps.add({
        source = "chrishrb/gx.nvim",
        depends = { "nvim-lua/plenary.nvim" },
    })

    require("gx").setup()
end)
