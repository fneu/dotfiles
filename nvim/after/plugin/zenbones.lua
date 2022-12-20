local ok, zenbones = pcall(require, "zenbones")
if not ok then
    return
end

local ok2, lush = pcall(require, "lush")
if not ok2 then
    return
end

vim.cmd("colorscheme zenbones")

local specs = lush.parse(function()
    return {
        NormalFloat {zenbones.Normal},

        DevIconDefault {zenbones.Type},

        NeoTreeCursorLine {zenbones.NvimTreeCursorLine},
        NeoTreeDimText {zenbones.Comment},
        NeoTreeDirectoryIcon {zenbones.Type},
        NeoTreeDirectoryName {zenbones.Directory},

        NeoTreeGitConflict {zenbones.WarningMsg},
        NeoTreeGitModified {zenbones.diffChanged},
        NeoTreeGitAdded {zenbones.diffAdded},
        NeoTreeGitDeleted {zenbones.diffRemoved},
        NeoTreeGitUntracked {zenbones.Comment},

        NeoTreeModified {zenbones.diffChanged},
        NeoTreeNormal { zenbones.NvimTreeNormal},
        NeoTreeRootName {zenbones.NvimTreeRootFolder},
        NeoTreeSymbolicLinkTarget {zenbones.NvimTreeSymlink},
        NeoTreeVertSplit {zenbones.NvimTreeWinSeparator},
        NeoTreeWinSeparator {zenbones.NvimTreeWinSeparator},     
        NeoTreeWindowsHidden {zenbones.Comment},
        NeoTreeFloatTitle {zenbones.FloatBorder},
        NeoTreeFloatBorder {zenbones.FloatBorder},
    }
end)
-- Apply specs using lush tool-chain
lush.apply(lush.compile(specs))
