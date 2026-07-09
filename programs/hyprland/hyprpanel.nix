{ pkgs, ... }:
{
  programs.hyprpanel = {
    # Configure and theme almost all options from the GUI.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {

      # Configure bar layouts for monitors.
      # See 'https://hyprpanel.com/configuration/panel.html'.
      # Default: null
      layout = {
        bar.layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [
              "clock"
              "media"
            ];
            right = [
              "volume"
              "systray"
              "notifications"
            ];
          };

        };
      };
            theme = 'everforest';

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;
      theme.bar.opacity = 85;
      theme.bar.blocks = "0px 14px 0px 14px";
      theme.bar.scaling = 75;
      theme.bar.margins_sides = "8px";
      theme.bar.margins_top = "6px";
      theme.bar.outer_gaps = true;
      theme.bar.radius = "16px";

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
