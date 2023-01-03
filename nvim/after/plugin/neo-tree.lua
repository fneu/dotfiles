local ok, neotree = pcall(require, "neo-tree")
if not ok then
    return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
neotree.setup({
    sources = {
        "filesystem",
    },
    popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid" and apparently "NC"
    -- source_selector provides clickable tabs to switch between sources.
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
        },
        modified = {
            symbol = "[+] ",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = true,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "",
                deleted   = "",
                modified  = "",
                renamed   = "",
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            },
            align = "right",
        },
    },
    renderers = {
        directory = {
            { "indent" },
            { "icon" },
            { "current_filter" },
            {
                "container",
                content = {
                    { "name", zindex = 10, use_git_status_colors=false},
                    { "clipboard", zindex = 10 },
                    { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
                    { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
                },
            },
        },
        file = {
            { "indent" },
            { "icon" },
            {
                "container",
                content = {
                    {
                        "name",
                        zindex = 10
                    },
                    { "clipboard", zindex = 10 },
                    { "bufnr", zindex = 10 },
                    { "modified", zindex = 20, align = "right" },
                    { "diagnostics",  zindex = 20, align = "right" },
                    { "git_status", zindex = 20, align = "right" },
                },
            },
        },
        message = {
            { "indent", with_markers = false },
            { "name", highlight = "NeoTreeMessage" },
        },
        terminal = {
            { "indent" },
            { "icon" },
            { "name" },
            { "bufnr" }
        }
    },
    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            -- ["S"] = "split_with_window_picker",
            ["s"] = "open_vsplit",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["R"] = "refresh",
            ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none" -- "none", "relative", "absolute"
                }
            },
            ["A"] = "add_directory", -- also accepts the config.show_path option.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
            ["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
            ["e"] = "toggle_auto_expand_width",
            ["q"] = "close_window",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
    },
    filesystem = {
        window = {
            mappings = {
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                --["/"] = "filter_as_you_type", -- this was the default until v1.28
                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",

                ["gs"] = "git_add_file",
                ["gS"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["gX"] = "git_revert_file",
                ["gcc"] = "git_commit",
                ["gP"] = "git_push",
            }
        },
        async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
        -- "always" means directory scans are always async.
        -- "never"  means directory scans are never async.
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        -- The renderer section provides the renderers that will be used to render the tree.
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
            show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                ".DS_Store",
                "thumbs.db"
                --"node_modules",
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json"
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",-- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
    },
})

vim.keymap.set('n', '-', ':Neotree<CR>')

