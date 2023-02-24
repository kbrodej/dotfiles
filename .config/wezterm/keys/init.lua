local wezterm = require 'wezterm'
local commands = require 'commands'

return {
  {
    key = 'e',
    mods = 'CMD',
    action = wezterm.action.SplitPane {
      direction = 'Right',
    },
  },
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitPane {
      direction = 'Down'
    }
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane {
      confirm = false,
    },
  },
  {
    key = 'o',
    mods = 'CMD|SHIFT',
    action = commands.toggle_transparency.action
  },
  {
    key = 'p',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = commands.swap_theme.action,
  },
}