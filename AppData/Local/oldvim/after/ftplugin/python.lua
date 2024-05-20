-- install with `pip install black`
vim.keymap.set("n", "g=", "<cmd>%!black -q -<cr>", {desc = "Format with black"})
