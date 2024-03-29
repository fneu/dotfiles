return {
    {
        "nvim-telescope/telescope.nvim",
        -- event = 'VimEnter',
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make", -- scoop install make mingw
                -- cond = function()
                --     return vim.fn.executable("make") == 1
                -- end,
            },
            "nvim-telescope/telescope-ui-select.nvim"
        },
        config = function(_, _)
            require "telescope".setup {
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key"
                        }
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }

            -- require "telescope".load_extension("fzf")
            require("telescope").load_extension("ui-select")

            -- KEYBINDINGS
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]iles"})
            vim.keymap.set("n", "<leader>f.", builtin.oldfiles, {desc = "[F]ind recent files ('.' for repeat)"})
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, {desc = "[F]ind [B]uffers"})
            vim.keymap.set(
                "n",
                "<leader>/",
                function()
                    builtin.current_buffer_fuzzy_find(
                        require("telescope.themes").get_dropdown {
                            winblend = 10,
                            previewer = false
                        }
                    )
                end,
                {desc = "[F]uzzy [/] search in current buffer"}
            )
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "[F]ind by [G]rep"})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "[F]ind [H]elp"})
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, {desc = "[F]ind [K]eymaps"})
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, {desc = "[F]ind current [W]ord"})
            vim.keymap.set("n", "<leader>fs", builtin.builtin, {desc = "[F]ind [S]elect Telescope"})
            vim.keymap.set("n", "<leader>fb", builtin.git_branches, {desc = "[F]ind Git [B]ranch"})
        end
    }
}
