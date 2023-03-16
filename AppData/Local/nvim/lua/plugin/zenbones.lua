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
            local palette = require "zenbones.palette"[vim.o.background]
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
                        RainbowRose {zenbones.Normal, fg=palette.rose.sa(30).li(10)},
                        RainbowWood {zenbones.Normal, fg=palette.wood.sa(30).li(20)},
                        RainbowWater {zenbones.Normal, fg=palette.water.sa(30).li(20)},
                        RainbowLeaf {zenbones.Normal, fg=palette.leaf.sa(30).li(20)},
                        RainbowBlossom {zenbones.Normal, fg=palette.blossom.sa(30).li(20)},
                        RainbowSky {zenbones.Normal, fg=palette.sky.sa(30).li(20)},
                    }
                end
            )
            -- Apply specs using lush tool-chain
            lush.apply(lush.compile(specs))
        end
    }
}
