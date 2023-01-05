-- install with `dotnet tool install -g csharpier`
vim.keymap.set("n", "g=", "<cmd>%!dotnet csharpier --write-stdout<cr>", {desc = "Format with luafmt"})
