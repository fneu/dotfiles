-- install with `scoop install xmllint`
vim.keymap.set("n", "g=", "<cmd>%!xmllint --format -<cr>", {desc = "Format with xmllint"})

vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- unfortunately, xml is not directly supported by treesitter (yet)
-- therefore, neither syntax highlighting nor folding is supported.
-- this depends on highlight.additional_vim_regex_highlighting being true for xml
--
-- Another potential solution would be to use the html treesitter syntax (ft=html)
-- but right now I'm having trouble installing it
vim.g.xml_syntax_folding = true
vim.opt_local.foldmethod = "syntax"
