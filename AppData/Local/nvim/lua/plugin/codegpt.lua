return {
    "dpayne/CodeGPT.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
        require("codegpt.config")
        vim.keymap.set("n", "<leader>a", ":Chat ", {desc = "CodeGPT [A]i chat"})
        vim.keymap.set("v", "<leader>a", ":Chat ", {desc = "CodeGPT [A]i code features"})
    end
}
