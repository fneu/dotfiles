-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- Keep active term windows in insert mode
local termGrp = vim.api.nvim_create_augroup("TermInsert", { clear = true })
vim.api.nvim_create_autocmd(
    {"TermOpen", "BufEnter", "WinEnter"}, {
    pattern = "term://*",
    command = "startinsert",
    group = termGrp,
})
