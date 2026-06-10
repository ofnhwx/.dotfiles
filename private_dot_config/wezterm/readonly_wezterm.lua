local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('UDEV Gothic NF')
config.font_size = 13.0
config.color_scheme = 'Modus-Vivendi'
config.default_cursor_style = 'SteadyBar'

config.window_background_opacity = 0.9
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_decorations = 'TITLE | RESIZE'
config.enable_tab_bar = false
config.use_ime = true
config.audible_bell = 'Disabled'

config.disable_default_key_bindings = true
config.keys = {
  { key = 'v',      mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'Insert', mods = 'SHIFT',      action = wezterm.action.PasteFrom 'Clipboard' },
}

return config
