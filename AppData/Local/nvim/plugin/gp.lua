MiniDeps.later(function()
    MiniDeps.add("Robitx/gp.nvim")
    local conf = {
        providers = {
            openai = {
                disable = true,
                endpoint = "https://api.openai.com/v1/chat/completions",
                secret = os.getenv("OPENAI_API_KEY"),
            },

            copilot = {
                endpoint = "https://api.githubcopilot.com/chat/completions",
                secret = {
                    "pwsh",
                    "-Command",
                    "cat ~/AppData/Local/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                },
            },
        },
        chat_template = require("gp.defaults").short_chat_template,
    }
    require("gp").setup(conf)

    vim.keymap.set({ "n", "x" }, "<space>cc", ":GpChatToggle popup<CR>", { remap = true, desc = "[C]opilot [C]hat" })
    vim.keymap.set({ "i", "n", "x" }, "<C-]>", ":GpChatRespond<CR>", { remap = true, desc = "copilot respond" })
    vim.keymap.set({ "n", "x" }, "<space>cn", ":GpChatNew popup<CR>", { remap = true, desc = "[C]opilot [N]ew" })
    vim.keymap.set({ "x" }, "<space>cp", ":GpChatPaste popup<CR>", { remap = true, desc = "[C]opilot [P]aste" })
    vim.keymap.set({ "x" }, "<space>ci", ":GpRewrite<CR>", { remap = true, desc = "[C]opilot [I]mplement" })
end)
