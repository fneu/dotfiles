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
    vim.keymap.set({ "n", "x" }, "<C-]>", ":GpChatRespond<CR>", { remap = true, desc = "copilot respond" })
    vim.keymap.set({ "i" }, "<C-]>", "<esc>:GpChatRespond<CR>", { remap = true, desc = "copilot respond" })
    vim.keymap.set({ "n", "x" }, "<space>cn", ":GpChatNew popup<CR>", { remap = true, desc = "[C]opilot [N]ew" })
    vim.keymap.set({ "x" }, "<space>cp", ":GpChatPaste popup<CR>", { remap = true, desc = "[C]opilot [P]aste" })
    vim.keymap.set({ "x" }, "<space>ci", ":GpRewrite<CR>", { remap = true, desc = "[C]opilot [I]mplement" })
    vim.keymap.set({ "x" }, "<space>cd", ":GpDiff ", { remap = true, desc = "[C]opilot rewrite to [D]iff" })

    function _G.gp_diff(args, line1, line2)
        local contents = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)

        vim.cmd("vnew")
        local scratch_buf = vim.api.nvim_get_current_buf()
        vim.bo[scratch_buf].buftype = "nofile"
        vim.bo[scratch_buf].bufhidden = "wipe"

        vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, contents)

        vim.cmd(line1 .. "," .. line2 .. "GpRewrite " .. args)

        vim.defer_fn(function()
            vim.cmd("diffthis")
            vim.cmd("wincmd p")
            vim.cmd("diffthis")
        end, 1000)
    end

    vim.cmd("command! -range -nargs=+ GpDiff lua gp_diff(<q-args>, <line1>, <line2>)")
end)
