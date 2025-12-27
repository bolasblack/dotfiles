-- https://wezterm.org/config/lua/wezterm/index.html
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action

wezterm.log_info('Config file ' .. wezterm.config_file)
wezterm.log_info('Config Dir ' .. wezterm.config_dir)

-- Appearance & Colors
config.colors = {
  foreground = '#bbbbbb',
  background = '#303030',
  cursor_bg = '#bbbbbb',
  cursor_fg = '#111111',
  selection_bg = '#b5d5ff',
  selection_fg = '#000000',
  
  ansi = {
    '#000000', -- Black
    '#bb0000', -- Red
    '#00bb00', -- Green
    '#bbbb00', -- Yellow
    '#0000bb', -- Blue
    '#bb00bb', -- Magenta
    '#00bbbb', -- Cyan
    '#bbbbbb', -- White
  },
  brights = {
    '#555555', -- Bright Black
    '#ff5555', -- Bright Red
    '#55ff55', -- Bright Green
    '#ffff55', -- Bright Yellow
    '#7777ff', -- Bright Blue
    '#ff55ff', -- Bright Magenta
    '#55ffff', -- Bright Cyan
    '#ffffff', -- Bright White
  },
}

-- Window Configuration
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.hide_mouse_cursor_when_typing = true
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}
config.initial_cols = 80
config.initial_rows = 25
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Font Configuration
config.font = wezterm.font_with_fallback {
  {
    family = 'Maple Mono Normal NF CN',
    harfbuzz_features = { 'cv96', 'cv97', 'cv98', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06' },
  },
}
config.font_size = 18

-- Cursor
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_thickness = '200%'
config.default_cursor_style = 'BlinkingUnderline'

-- General Settings
config.send_composed_key_when_left_alt_is_pressed = false -- macos-option-as-alt = true
config.send_composed_key_when_right_alt_is_pressed = false
config.scrollback_lines = 1000000
config.animation_fps = 120

-- Keybindings
config.keys = {
  -- Reset keybindings
  { key = "Enter", mods = "OPT", action = act.DisableDefaultAssignment },

  -- Window/Tab Management
  { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
  { key = 'n', mods = 'CMD', action = act.SpawnWindow },
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'Enter', mods = 'CMD', action = act.ToggleFullScreen },
  
  -- Splits
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Clear Screen
  { key = 'k', mods = 'CMD', action = act.ClearScrollback 'ScrollbackOnly' },

  -- Copy/Paste (usually default, but adding explicit to match intent)
  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
  
  -- Inspector (Ghostty cmd+i)
  { key = 'i', mods = 'CMD', action = act.ShowDebugOverlay },
}

return config
