local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()

config.default_prog = { "pwsh.exe", "-NoLogo" }
config.font = wezterm.font("MonoLisa NF")
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- Fancy tab bar cannot be themed by color schemes,
-- only by custom config
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.disable_default_key_bindings = true

-- Colors
config.colors = {
	foreground = "#e0e2ea",
	background = "#14161b",

	cursor_fg = "e0e2ea",
	cursor_bg = "#9b9ea4",
	cursor_border = "e0e2ea",

	selection_fg = "none",
	selection_bg = "#4f5258",

	-- The color of the split lines between panes
	split = "e0e2ea",

	-- dark nvim colors brightened 30%
	ansi = {
		"#07080d",
		"#ffc0b9",
		"#b3f6c0",
		"#fce094",
		"#a6dbff",
		"#ffcaff",
		"#8cf8f7",
		"#eef1f8",
	},
	brights = {
		"#9b9ea4",
		"#ffc0b9",
		"#b3f6c0",
		"#fce094",
		"#a6dbff",
		"#ffcaff",
		"#8cf8f7",
		"#eef1f8",
	},
	tab_bar = {
		background = "#2c2e33",
		active_tab = {
			bg_color = "#14161b",
			fg_color = "#e0e2ea",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#2c2e33",
			fg_color = "#c4c6cd",
		},
		inactive_tab_hover = {
			bg_color = "#4f5258",
			fg_color = "#e0e2ea",
			italic = true,
		},
		new_tab = {
			bg_color = "#2c2e33",
			fg_color = "#c4c6cd",
		},
		new_tab_hover = {
			bg_color = "#4f5258",
			fg_color = "#e0e2ea",
			italic = true,
		},
	},
}

-- Directory name in tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local current_dir = (string.gsub(tab.active_pane.current_working_dir.path, "/$", ""))
	local home_dir = "/" .. wezterm.home_dir:gsub("\\", "/")
	return current_dir == home_dir and tab.tab_index + 1 .. ": ~ "
		or tab.tab_index + 1 .. ": " .. string.gsub(current_dir, "(.*[/\\])(.*)", "%2") .. " "
end)

-- Show active workspace in right status
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = "#9b9ea4" } },
		{ Text = window:active_workspace() },
	}))
end)

-- Keybindings
config.keys = {

	-- Window
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "m", mods = "ALT", action = act.Hide },
	{ key = "0", mods = "ALT", action = act.ResetFontSize },
	{ key = "+", mods = "ALT", action = act.IncreaseFontSize },
	{ key = "-", mods = "ALT", action = act.DecreaseFontSize },
	{ key = "/", mods = "SHIFT|ALT", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "?", mods = "SHIFT|ALT", action = act.QuickSelect },
	{ key = ":", mods = "SHIFT|ALT", action = act.ActivateCommandPalette },
	{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
	{ key = "o", mods = "ALT", action = act.ShowDebugOverlay },

	-- Clipboard
	{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
	{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },

	-- Scroll similar to vim
	{ key = "u", mods = "ALT", action = act.ScrollByPage(-0.5) },
	{ key = "d", mods = "ALT", action = act.ScrollByPage(0.5) },
	{ key = "b", mods = "ALT", action = act.ScrollByPage(-1) },
	{ key = "f", mods = "ALT", action = act.ScrollByPage(1) },

	-- Tabs
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "n", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
	{ key = "p", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
	-- conflicts with reset font size
	-- { key = '0', mods = 'ALT', action = act.ActivateTab(9) },
	{ key = "ß", mods = "ALT", action = act.ActivateTab(-1) },

	-- Panes
	{ key = "v", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "ALT", action = act.TogglePaneZoomState },
	{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },

	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "h", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "j", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "k", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "l", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "DownArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "UpArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "RightArrow", mods = "SHIFT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },

	-- Workspaces
	{ key = "p", mods = "ALT|SHIFT", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
	{
		key = "p",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local projects = {}
			local success, stdout, stderr = wezterm.run_child_process({
				wezterm.home_dir .. "/scoop/shims/fd.exe",
				"-HI",
				"-td",
				"^.git$",
				"--max-depth=4",
				wezterm.home_dir .. "\\devel",
				wezterm.home_dir .. "\\icadev",
				"D:\\devel",
				"D:\\icadev",
				-- add more paths here
			})

			if not success then
				wezterm.log_error("Failed to run fd: " .. stderr)
				return
			end

			table.insert(projects, { label = wezterm.home_dir, id = "default" })

			for line in stdout:gmatch("([^\n]*)\n?") do
				local project = line:gsub("\\.git\\$", "")
				local label = project
				local id = project:gsub(".*\\", "")
				table.insert(projects, { label = tostring(label), id = tostring(id) })
			end

			window:perform_action(
				act.InputSelector({
					action = wezterm.action_callback(function(win, _, id, label)
						if not id and not label then
							wezterm.log_info("Cancelled")
						else
							wezterm.log_info("Selected " .. label)
							win:perform_action(act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }), pane)
						end
					end),
					fuzzy = true,
					title = "Select project",
					choices = projects,
				}),
				pane
			)
		end),
	},
}

return config
