return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function(_, _)
            require "nvim-web-devicons".setup {
                override = {
                    cake = {
                        icon = "",
                        color = "#000000",
                        cterm_color = "00",
                        name = "Cake"
                    },
                    csproj = {
                        icon = "",
                        color = "#000000",
                        cterm_color = "00",
                        name = "Csproj"
                    },
                    pyproj = {
                        icon = "",
                        color = "#000000",
                        cterm_color = "00",
                        name = "Pyproj"
                    }
                },
                color_icons = false,
                default = true
            }
        end
    }
}
