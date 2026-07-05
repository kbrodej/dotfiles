local wezterm = require 'wezterm'

local command = {
  brief = 'Swap between Catppuccin Mocha and Latte themes',
  icon = 'md_palette',
  action = wezterm.action_callback(function(window)
    local overrides = window:get_config_overrides() or {}
    
    local new_theme
    if not overrides.color_scheme or overrides.color_scheme == 'Catppuccin Mocha' then
      new_theme = 'Catppuccin Latte'
    else
      new_theme = 'Catppuccin Mocha'
    end
    
    overrides.color_scheme = new_theme
    window:set_config_overrides(overrides)
    
    -- Update shell environment variable
    local git_dirty_bg = (new_theme == 'Catppuccin Latte') and '091' or 'yellow'
    window:perform_action(
      wezterm.action.SendString('export AGNOSTER_GIT_DIRTY_BG="' .. git_dirty_bg .. '"; clear\n'),
      window:active_pane()
    )
    
  end),
}

return command