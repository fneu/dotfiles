return {
    "dpayne/CodeGPT.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
        require("codegpt.config")
        vim.keymap.set("i", "<C-c>", "<Esc>V:Chat completion<CR>", {desc = "CodeGPT [A]i completion"})
        vim.keymap.set("n", "<C-c>", ":Chat ", {desc = "CodeGPT [A]i chat"})
        vim.keymap.set("v", "<C-c>", ":Chat ", {desc = "CodeGPT [A]i code features"})
    end
}
