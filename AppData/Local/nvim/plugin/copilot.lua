MiniDeps.later(function()
    MiniDeps.add({
        source = "zbirenbaum/copilot.lua",
    })

    require("copilot").setup({
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
                accept = "<C-l>",
                accept_word = false,
                accept_line = false,
                next = "<C-j>",
                prev = "<C-k>",
                dismiss = "<C-h>",
            },
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
    })
end)
