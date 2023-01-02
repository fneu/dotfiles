local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup{
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
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

telescope.load_extension('fzf')

-- KEYBINDINGS
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, {desc='[ ] Find files'})
vim.keymap.set('n', '<leader>f?', builtin.find_files, {desc='[F]ind [?] recently opened files'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc='[F]ind [B]uffers'})
vim.keymap.set('n', '<leader>/',
    function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{
        winblend = 10,
        previewer = false,
    })
    end,
    {desc="[F]uzzy [/] search in current buffer"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="[F]ind by [G]rep"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="[F]ind [H]elp"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc="[F]ind [K]eymaps"})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc="[F]ind current [W]ord"})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {desc="[F]ind [S]ymbol"})

vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {desc="[F]ind [G]it [B]ranch"})
vim.keymap.set('n', '<leader>fgs', builtin.git_stash, {desc="[F]ind [G]it [S]tashes"})
