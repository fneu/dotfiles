return {
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
            "nvim-tree/nvim-web-devicons"  -- load devicons first, overwrite it's highlight group after
        },
        config = function(_, _)
            vim.cmd("colorscheme zenbones")
            local zenbones = require "zenbones"
            local lush = require "lush"

            local specs =
                lush.parse(
                function()
                    return {
                        NormalFloat {zenbones.Normal},
                        DevIconDefault {zenbones.Type},
                        OilDir {zenbones.Directory},
                        OilChange {zenbones.diffChanged},
                        OilCopy {zenbones.diffAdded},
                        OilCreate {zenbones.diffAdded},
                        OilDelete {zenbones.diffRemoved},
                        OilMove {zenbones.diffChanged},
                    }
                end
            )
            -- Apply specs using lush tool-chain
            lush.apply(lush.compile(specs))
        end
    }
}
