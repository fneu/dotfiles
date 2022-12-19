local ok, ssr = pcall(require, "ssr")
if not ok then
    return
end

vim.keymap.set({ "n", "x" }, "<leader>sr", function() ssr.open() end)
