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
local harmon

config.window_background_opacity = 0.96
config.bold_brightens_ansi_colors = false
config.color_scheme = 'Harmonia Night (personal)'
config.color_schemes = {
	['Harmonia Night v1'] = {
		background = '#222020',
		foreground = '#bdb7b5',
		cursor_bg = '#ede4e3',
		cursor_fg = '#161515',
		selection_bg = '#908b8a',
		selection_fg = '#2e2c2b',
		ansi = {
			'#181717', -- black
			'#a65354', -- red
			'#497f44', -- green
			'#7b7120', -- yellow
			'#5b70a6', -- blue
			'#96568e', -- magenta
			'#0d8181', -- cyan
			'#ddd5d3', -- white
		},
		brights = {
			'#4a4746',
			'#e37376',
			'#66ae06',
			'#aa9c30',
			'#7e9be3',
			'#ce78c3',
			'#15b1b1',
			'#fdf4e2',
		},
	},
	['Harmonia Night v2'] = {
		background = '#3b3938',
		foreground = '#f9f2f0',
		cursor_fg = '#323232',
		cursor_bg = '#fffaf8',
		selection_bg = '#f1eae8',
		selection_fg = '#413f3e',
		ansi = {
			'#5f5c5b',
			'#c47876',
			'#709e6b',
			'#ab8a49',
			'#8290be',
			'#af7eb0',
			'#599fa1',
			'#cdc7c6',
		},
		brights = {
			'#8c8887',
			'#fea4a1',
			'#9cd195',
			'#e1ba6e',
			'#b1c0f5',
			'#e5abe5',
			'#84d1d4',
			'#fffaf8',
		},
	},
	['Harmonia Night (personal)'] = {
		background = '#333232',
		foreground = '#faf2f0',
		cursor_bg = '#e0dddd',
		cursor_fg = '#272525',
		selection_bg = '#dfdbda',
		selection_fg = '#4a4847',
		ansi = {
				'#646161',
				'#c77878',
				'#80b079',
				'#b2a861',
				'#849bc0',
				'#bc8ebc',
				'#68aca5',
				'#e0dddd',
		},
		brights = {
				'#9b9998',
				'#fd9798',
				'#b0dfb0',
				'#e9d28c',
				'#bcc9f8',
				'#f1b1ef',
				'#9edbe1',
				'#ffffff',
		},
	},
}

-- and finally, return the configuration to wezterm
return config
