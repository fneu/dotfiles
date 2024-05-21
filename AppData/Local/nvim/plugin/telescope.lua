MiniDeps.add{
    source="nvim-telescope/telescope.nvim",
    checkout="0.1.x",
    depends = {
        "nvim-lua/plenary.nvim",
        {
            source = "nvim-telescope/telescope-fzf-native.nvim",
            hooks = {
                post_install = function(args)
                    local path = args.path
                    vim.fn.system({'make'}, path)
                end
            }
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
    }
}

MiniDeps.later(function()
    require("telescope").setup{
        extensions = {
            ['ui-select'] = {
                require("telescope.themes").get_dropdown {},
            }
        }
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require "telescope.builtin"

    vim.keymap.set("n", "<leader><leader>", builtin.find_files, {desc = "find files"})
    vim.keymap.set("n", "<leader>ff", builtin.buffers, {desc = "[F]ind buffers (open [F]iles)"})
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, {desc = "[F]ind recent files ('.' for repeat)"})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "[F]ind by [G]rep"})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "[F]ind [H]elp"})
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, {desc = "[F]ind [K]eymaps"})
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, {desc = "[F]ind current [W]ord"})
    vim.keymap.set("n", "<leader>fs", builtin.builtin, {desc = "[F]ind [S]elect Telescope"})
    vim.keymap.set("n", "<leader>fb", builtin.git_branches, {desc = "[F]ind Git [B]ranch"})
    vim.keymap.set("n", "<leader>fc", builtin.git_commits, {desc = "[F]ind Git [C]ommit"})
    vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
    vim.keymap.set("n", "<space>fn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, {desc = "[F]ind [N]eovim config"})
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>f:', builtin.commands, { desc = '[S]earch [:] Commands' })
end)
