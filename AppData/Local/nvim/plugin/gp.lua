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

    vim.keymap.set({ "n", "x" }, "üt", ":GpChatToggle popup<CR>", { remap = true, desc = "[Ü]ber [T]oggle " })
    vim.keymap.set({ "n", "x" }, "üü", ":GpChatRespond<CR>", { remap = true, desc = "[Ü]ber [Ü]bergib" })
    vim.keymap.set({ "n", "x" }, "ün", ":GpChatNew popup<CR>", { remap = true, desc = "[Ü]ber [N]ew" })
    vim.keymap.set({ "x" }, "üp", ":GpChatPaste popup<CR>", { remap = true, desc = "[Ü]ber [P]aste" })
    vim.keymap.set({ "x" }, "ür", ":GpRewrite<CR>", { remap = true, desc = "[Ü]ber [R]ewrite" })
end)
