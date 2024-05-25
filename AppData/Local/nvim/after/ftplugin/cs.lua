vim.bo.commentstring = "// %s"

-- Goto Test
local toggle_test = function()
    local current_file = vim.fn.expand("%:p")
    local is_src_file = current_file:find("[/\\]tests[/\\]") == nil
    if is_src_file then
        vim.cmd("edit " .. current_file:gsub("[/\\]src[/\\]", "/tests/Test."):gsub("%.cs$", "Tests.cs"))
    else
        vim.cmd("edit " .. current_file:gsub("[/\\]tests[/\\]Test.", "/src/"):gsub("%Tests.cs$", ".cs"))
    end
end

vim.keymap.set("n", "<leader>tt", toggle_test, { desc = "[T]o [T]est" })

-- Find and rebuild projects and solutions with custom telescope picker
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local msbuild_projects = function(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "Rebuild Projects/Solutions",
            finder = finders.new_oneshot_job({ "fd", "-e", "sln", "-e", "csproj" }, opts),
            -- finder = finders.new_oneshot_job({'find','"sln$|csproj$"'}, opts),
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    print(selection[1])

                    vim.cmd(
                        ":botright 12split term://dotnet build "
                            .. selection[1]
                            .. " /t:Rebuild /p:Configuration=Debug /p:WarningLevel=0 /p:ResolveAssemblyWarnOrErrorOnTargetArchitectureMismatch=None /p:nowarn=NU1701"
                    )
                    vim.cmd("$")
                end)
                return true
            end,
        })
        :find()
end

vim.keymap.set("n", "<leader>fp", function()
    msbuild_projects(require("telescope.themes").get_dropdown({}))
end, { desc = "[F]ind [P]rojects and rebuild", buffer = true })
