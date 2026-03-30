-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font Settings
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Symbola",
})
config.font_size = 12
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = false
config.use_dead_keys = false
config.enable_scroll_bar = true
config.window_background_opacity = 0.80
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"

config.color_scheme = "Dracula"
config.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.8,
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "s", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h", action = act.MoveTabRelative(-1) },
    { key = "j", action = act.MoveTabRelative(-1) },
    { key = "k", action = act.MoveTabRelative(1) },
    { key = "l", action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}

-- Tab Bar Settings
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Slowed down to 2000ms to reduce UI stutter
config.status_update_interval = 2000 

wezterm.on("update-right-status", function(window, pane)
  local stat = window:active_workspace()
  
  if window:active_key_table() then
    stat = window:active_key_table()
  end
  if window:leader_is_active() then
    stat = "LDR"
  end

  local basename = function(s)
    if not s or type(s) ~= "string" then return "" end
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Properly handle the URL object for CWD
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ""
  if cwd_uri then
    cwd = basename(cwd_uri.file_path or "")
  end

  -- Performance & GPU Rendering Tweaks
  config.front_end = "WebGpu" 
  config.webgpu_power_preference = "HighPerformance"
  config.enable_wayland = true
  config.max_fps = 144 

  local cmd_name = pane:get_foreground_process_name() or ""
  local cmd = basename(cmd_name)

  local time = wezterm.strftime("%H:%M")
  window:set_right_status(wezterm.format({
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = "FFB86C" } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = " |" },
  }))
end)

return config