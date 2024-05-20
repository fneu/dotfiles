-- install with `npm install lua-fmt`
vim.keymap.set("n", "g=", "<cmd>%!luafmt.cmd --stdin<cr>", {desc = "Format with luafmt"})
