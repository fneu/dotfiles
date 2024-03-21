return {
    "zbirenbaum/copilot.lua",
    cmd= "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup(
            {
                panel = {
                    auto_refresh = false,
                    keymap = {
                        accept = "<CR>",
                        jump_prev = "[[",
                        jump_next = "]]",
                        refresh = "gr",
                        open = "<M-CR>"
                    }
                },
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-l>",
                        prev = "<C-k>",
                        next = "<C-j>",
                        dismiss = "<C-h>"
                    }
                }
            }
        )
    end
}
