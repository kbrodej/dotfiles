local wezterm = require 'wezterm'
local commands = require 'commands'
local keys = require 'keys'
-- This will hold the configuration.
local config = wezterm.config_builder()

-- Windows:

config.initial_cols = 240
config.initial_rows = 60
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Catppuccin Latte"
-- config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Fonts
config.font = wezterm.font("UbuntuMono Nerd Font Mono")
config.font_size = 14
config.window_padding = {
  left = 10,
  right = 0,
  top = 10,
  bottom = 0,
}
config.macos_window_background_blur = 20
config.window_background_opacity = 0.8
-- Misc
config.max_fps = 120
config.prefer_egl = true

-- Keys

config.keys = keys

-- Commands

wezterm.on('augment-command-palette', function()
  return commands
end)

return config