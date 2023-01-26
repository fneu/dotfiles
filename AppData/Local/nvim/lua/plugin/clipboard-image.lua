return {
    {
        "ekickx/clipboard-image.nvim",
        config = function(_, _)
            require'clipboard-image'.setup {
              default = {
               img_dir = {"%:p:h", "img", "%:t:r"},  -- save picture as /img/<name-of-current-file>/image.png relative to current file
               img_dir_txt = {"img", "%:t:r"}  -- show only relative path in file
              }
            }
            vim.keymap.set("n", "<leader>pi", ":PasteImg<cr>", {desc = "[G]it [K]"})
        end
    }
}
