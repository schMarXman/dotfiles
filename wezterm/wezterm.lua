local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.xcursor_theme = "Yaru"
config.front_end = 'WebGpu'

-- gnome cursor fixes: https://github.com/wez/wezterm/issues/1742
local xcursor_size = nil
local xcursor_theme = nil

local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-theme"})
if success then
  xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
end

local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-size"})
if success then
  xcursor_size = tonumber(stdout)
end

config.xcursor_theme = xcursor_theme
config.xcursor_size = xcursor_size
-- ===========

return config
