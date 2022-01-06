local wezterm = require 'wezterm';

return {
    font = wezterm.font("Fira Code"),
    color_scheme = "Gruvbox Dark",
    hide_tab_bar_if_only_one_tab = true,
    font_size = 14.0,

    keys = {
        { key = "\"", mods = "CTRL", action = {SplitVertical={domain="CurrentPaneDomain"}} },
        { key = "%", mods = "CTRL", action = {SplitHorizontal={domain="CurrentPaneDomain"}} },
    },
}
