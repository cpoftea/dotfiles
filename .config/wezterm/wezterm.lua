-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.prefer_to_spawn_tabs = true
config.enable_scroll_bar = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_update_window = true

-- Font
config.font_size = 14
config.font = wezterm.font 'BlexMono Nerd Font Mono'
config.adjust_window_size_when_changing_font_size = false

-- Macos specific
config.macos_window_background_blur = 20
config.native_macos_fullscreen_mode = true

-- Style
config.window_background_opacity = 0.96
config.bold_brightens_ansi_colors = false
config.color_scheme = 'Harmonia Night v1'
config.color_schemes = {
	['Harmonia Night v1'] = {
		background = '#222020',
		foreground = '#bdb7b5',
		cursor_bg = '#ede4e3',
		cursor_fg = '#161515',
		selection_bg = '#908b8a',
		selection_fg = '#2e2c2b',
		ansi = {
			'#4a4746', -- black
			'#e37376', -- red
			'#66ae06', -- green
			'#aa9c30', -- yellow
			'#7e9be3', -- blue
			'#ce78c3', -- magenta
			'#15b1b1', -- cyan
			'#fdf4e2', -- white
		},
	}
}

-- and finally, return the configuration to wezterm
return config
