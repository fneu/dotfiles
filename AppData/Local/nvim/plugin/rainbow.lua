MiniDeps.later(function()
    MiniDeps.add("HiPhish/rainbow-delimiters.nvim")

    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "NvimLightRed" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "NvimLightGreen" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "NvimLightYellow" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "NvimLightBlue" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "NvimLightMagenta" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "NvimLightCyan" })

    local rainbow_delimiters = require("rainbow-delimiters")
    require("rainbow-delimiters.setup").setup({
        strategy = {
            [""] = rainbow_delimiters.strategy["global"],
            vim = rainbow_delimiters.strategy["local"],
        },
        query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
        },
        priority = {
            [""] = 110,
            lua = 210,
        },
        highlight = {
            "RainbowDelimiterCyan",
            "RainbowDelimiterViolet",
            "RainbowDelimiterGreen",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterRed",
        },
    })
end)
