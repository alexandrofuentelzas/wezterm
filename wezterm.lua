local wezterm = require("wezterm")
local act = wezterm.action

return {
  font = wezterm.font("JetBrains Mono", { weight = 'Bold', italic = false }),
  keys = {
    -- Tab navigation with CMD + Arrows
    {
      key = "LeftArrow",
      mods = "CMD",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = "RightArrow",
      mods = "CMD",
      action = act.ActivateTabRelative(1),
    },

    -- Pane navigation with CMD + OPT + Arrows
    { key = "LeftArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Left" },
    { key = "RightArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Right" },
    { key = "UpArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Up" },
    { key = "DownArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Down" },

    -- WezTerm native pane splitting
    {
      key = "d",
      mods = "CMD",
      action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    -- TMUX session splitting and attaching
    {
      key = "d",
      mods = "CMD|CTRL",
      action = wezterm.action_callback(function(pane)
        local tmux_socket = wezterm.pane.get_environment_variables(pane)['TMUX']
        return act.SplitVertical {
          domain = "CurrentPaneDomain",
          args = { "tmux", "attach", "-t", tmux_socket }
        }
      end),
    },
    {
      key = "d",
      mods = "CMD|CTRL|SHIFT",
      action = wezterm.action_callback(function(pane)
        local tmux_socket = wezterm.pane.get_environment_variables(pane)['TMUX']
        return act.SplitHorizontal {
          domain = "CurrentPaneDomain",
          args = { "tmux", "attach", "-t", tmux_socket }
        }
      end),
    },
  },
}
