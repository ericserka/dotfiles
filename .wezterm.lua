-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("Fira Code Nerd Font Mono")

-- For example, changing the color scheme:
config.color_scheme = "tokyonight"

-- and finally, return the configuration to wezterm
return config
