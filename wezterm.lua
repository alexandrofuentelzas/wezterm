local wezterm = require("wezterm")
local act = wezterm.action

return {
  font = wezterm.font("JetBrains Mono", { weight = 'Bold', italic = false }),
  enable_scroll_bar = true,
  scrollback_lines = 25000,
  colors = {
      cursor_bg = "#CCCCCC",
  },
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
    {
        key = "k",
        mods = "CMD",
        action = act.ClearScrollback "ScrollbackAndViewport",
    },
  },
}
