return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    theme = "zenbones",
                    disabled_filetypes = {"neotest-summary"}
                },
                sections = {
                    lualine_b = {
                        "branch",
                        "diff",
                        {
                            "diagnostics",
                            symbols = {error = "", warn = "", info = "", hint = ""}
                        }
                    }
                },
                inactive_sections = {
                    lualine_b = {function() return vim.fn.bufnr('%') end}
                }
            }
        end
    }
}
