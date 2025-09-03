local wezterm = require("wezterm")
local act = wezterm.action

local function smart_split(pane, direction)
  if wezterm.pane.get_environment_variables(pane)['TMUX'] then
    -- We are in a tmux session (local or remote), so send the tmux key sequence
    if direction == "Vertical" then
      return act.SendString "\x02%"
    else
      return act.SendString "\x02\""
    end
  else
    -- Not in a tmux session, so use WezTerm's native split action
    if direction == "Vertical" then
      return act.SplitVertical { domain = "CurrentPaneDomain" }
    else
      return act.SplitHorizontal { domain = "CurrentPaneDomain" }
    end
  end
end

return {
  keys = {
    -- Tab navigation
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
    -- Pane navigation
    { key = "LeftArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Left" },
    { key = "RightArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Right" },
    { key = "UpArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Up" },
    { key = "DownArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection "Down" },

    -- Smart split function for CMD+D and CMD+Shift+D
    {
      key = "d",
      mods = "CMD",
      action = wezterm.action_callback(function(pane)
        return smart_split(pane, "Vertical")
      end),
    },
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = wezterm.action_callback(function(pane)
        return smart_split(pane, "Horizontal")
      end),
    },
  },
}
