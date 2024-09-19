local wezterm = require 'wezterm'
local act = wezterm.action

return {
    -- Environment Variables
    set_environment_variables = {
        LANG = "en_US.UTF-8"
    },

    -- Default Program
    default_prog = {"pwsh", "-NoLogo"},

    -- Font and Rendering Settings
    font = wezterm.font('JetBrainsMono Nerd Font'),
    freetype_load_target = "Normal",
    freetype_render_target = "HorizontalLcd",
    enable_tab_bar = false, -- Disabling tab bar for a cleaner look

    -- Appearance Settings
    color_scheme = 'Catppuccin Mocha',
    window_background_opacity = 0.95,

    -- Window Frame Customization
    window_frame = {
        active_titlebar_bg = "#1e1e2e",
        font = wezterm.font {
            family = "JetBrains Mono",
            weight = "Bold"
        },
        font_size = 11.0
    },

    -- Default Working Directory
    default_cwd = "~",

    -- Window Decorations and Tab Bar
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    enable_scroll_bar = true,

    -- Key Bindings
    keys = {{
        -- Split Pane Horizontally
        key = 's',
        mods = 'CTRL|SHIFT',
        action = act.SplitHorizontal {
            domain = 'CurrentPaneDomain'
        }
    }, {
        -- Split Pane Vertically
        key = 's',
        mods = 'CTRL|ALT',
        action = act.SplitVertical {
            domain = 'CurrentPaneDomain'
        }
    }, {
        -- Adjust Pane Size (Left)
        key = 'LeftArrow',
        mods = 'CTRL|SHIFT',
        action = act.AdjustPaneSize {"Left", 5}
    }, {
        -- Adjust Pane Size (Right)
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action = act.AdjustPaneSize {"Right", 5}
    }, {
        -- Activate Pane (Left)
        key = 'LeftArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Left'
    }, {
        -- Activate Pane (Right)
        key = 'RightArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Right'
    }, {
        -- Activate Pane (Down)
        key = 'DownArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Down'
    }, {
        -- Activate Pane (Up)
        key = 'UpArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Up'
    }, {
        -- Alternate Activate Pane (Left)
        key = 'h',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Left'
    }, {
        -- Alternate Activate Pane (Down)
        key = 'j',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Down'
    }, {
        -- Alternate Activate Pane (Up)
        key = 'k',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Up'
    }, {
        -- Alternate Activate Pane (Right)
        key = 'l',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Right'
    }, {
        -- Close Current Pane
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = act.CloseCurrentPane {
            confirm = false
        }
    }, {
        -- Scroll Up
        key = 'b',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(-1)
    }, {
        -- Scroll Down
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(1)
    }, {
        -- Toggle Pane Zoom State
        key = 'z',
        mods = 'CTRL',
        action = act.TogglePaneZoomState
    }, {
        -- Quick Select
        key = 'u',
        mods = 'CTRL|SHIFT',
        action = act.QuickSelect
    }}
}
