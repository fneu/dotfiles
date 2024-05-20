return {

            {
                "kylechui/nvim-surround",
                version = "*", -- Use for stability; omit to use `main` branch for the latest features
                config = function(_, _)
                    require("nvim-surround").setup(
                        {
                            keymaps = {
                                insert = "<C-g>s",
                                normal = "ys",
                                normal_cur = "yss",
                                visual = "S",
                                delete = "ds",
                                change = "cs",
                                -- necessary for linewise addition of normal visual selection
                                insert_line = "<C-g>S",
                                normal_line = "yS",
                                normal_cur_line = "ySS",
                                visual_line = "gS"
                            }
                        }
                    )
                end
            }

}
