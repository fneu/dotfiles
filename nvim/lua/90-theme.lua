vim.o.termguicolors = true
vim.o.background="light"
vim.cmd("colorscheme zenbones")

local lush = require "lush"
local base = require "zenbones"

-- Create some specs
local specs = lush.parse(function()
    return {
        NormalFloat {base.Normal},  -- lighter background, fits better with float borderlighter background, fits better with float border

        DevIconDefault {base.Type},

        NeoTreeCursorLine {base.NvimTreeCursorLine},
        NeoTreeDimText {base.Comment},
        NeoTreeDirectoryIcon {base.Type},
        NeoTreeDirectoryName {base.Directory},
        NeoTreeGitConflict {base.WarningMsg},
        NeoTreeGitModified {base.diffChanged},
        NeoTreeGitUntracked {base.Comment},
        NeoTreeModified {base.diffChanged},
        NeoTreeNormal { base.NvimTreeNormal},
        NeoTreeRootName {base.NvimTreeRootFolder},
        NeoTreeSymbolicLinkTarget {base.NvimTreeSymlink},
        NeoTreeVertSplit {base.NvimTreeWinSeparator},
        NeoTreeWinSeparator {base.NvimTreeWinSeparator},     
        NeoTreeWindowsHidden {base.Comment},
    }
end)
-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))
