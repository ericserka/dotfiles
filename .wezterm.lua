local wezterm = require("wezterm")

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("Fira Code Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"

-- and finally, return the configuration to wezterm
return config
