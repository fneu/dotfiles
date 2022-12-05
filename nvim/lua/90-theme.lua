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

        NeoTreeCursorLine {base.NvimTreeCursorLine},         --|hl-CursorLine| override in Neo-tree window.
        NeoTreeDirectoryIcon {base.Type},
        NeoTreeDirectoryName {base.Directory},
        NeoTreeGitConflict {base.WarningMsg},        --File name when the git status is conflict.
        NeoTreeGitUntracked {base.Comment},       --File name when the git status is untracked.
        NeoTreeGitModified {base.diffChanged},       --File name when the git status is untracked.
        NeoTreeNormal { base.NvimTreeNormal},             --|hl-Normal| override in Neo-tree window.
        NeoTreeVertSplit {base.NvimTreeWinSeparator},          --|hl-VertSplit| override in Neo-tree window.
        NeoTreeWinSeparator {base.NvimTreeWinSeparator},     
        NeoTreeRootName {base.NvimTreeRootFolder},           --The name of the root node.
        NeoTreeSymbolicLinkTarget {base.NvimTreeSymlink}, --Symbolic link target.
        NeoTreeWindowsHidden {base.Comment},      --Used for icons and names that are hidden on Windows.
        NeoTreeDimText {base.Comment}
    }
end)
-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))
