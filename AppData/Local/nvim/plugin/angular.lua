-- setup custom filetype for angular files to use treesitters angular parser
-- https://github.com/dlvandenberg/tree-sitter-angular

vim.filetype.add({
    pattern = {
        [".*%.component%.html"] = "angular.html", -- Sets the filetype to `angular.html` if it matches the pattern
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "angular.html",
    callback = function()
        vim.treesitter.language.register("angular", "angular.html") -- Register the filetype with treesitter for the `angular` language/parser
    end,
})
