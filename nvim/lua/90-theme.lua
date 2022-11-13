vim.o.termguicolors = true
vim.o.background="light"
vim.cmd("colorscheme zenbones")

local lush = require "lush"
local base = require "zenbones"

-- Create some specs
local specs = lush.parse(function()
    return {
        NormalFloat {base.Normal}  -- lighter background, fits better with float borderlighter background, fits better with float border
    }
end)
-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))
