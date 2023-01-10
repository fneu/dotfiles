local ok, colors = pcall(require, "nvim-highlight-colors")
if not ok then
    return
end

colors.setup {}
