local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.xcursor_theme = "Yaru"
config.front_end = 'WebGpu'
return config
