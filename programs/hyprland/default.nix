{ pkgs, config, ... }:

let
  border-size = config.var.theme.border-size;
  gaps-in = config.var.theme.gaps-in;
  gaps-out = config.var.theme.gaps-out;
  active-opacity = config.var.theme.active-opacity;
  inactive-opacity = config.var.theme.inactive-opacity;
  rounding = config.var.theme.rounding;
  blur = config.var.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
in
{
  imports = [
    ./animations.nix
    ./bindings.nix
    # ./hyprspace.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./hoyprlock.nix
    # ./hyprpanel.nix
  ];

  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6ct
    hyprshot
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    wl-clipboard
    brightnessctl
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    glib
    direnv
    meson
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # xwayland.enable = true;
    # systemd.enable = true;
    #
    # extraConfig = ''
    #         windowrule = opacity 0.0 override, class:^(xwaylandvideobridge)$
    #   windowrule = noanim, class:^(xwaylandvideobridge)$
    #   windowrule = noinitialfocus, class:^(xwaylandvideobridge)$
    #   windowrule = maxsize 1 1, class:^(xwaylandvideobridge)$
    #   windowrule = noblur, class:^(xwaylandvideobridge)$
    #   windowrule = nofocus, class:^(xwaylandvideobridge)$
    # '';

    settings = {

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";
      "$ctrlMod" = "SUPER_CTRL";

      monitor = [
        "eDP-2,2560x1600@165.0,0x1080,1.3333333"
        "HDMI-A-1,1920x1080@60.0,0x0,1.0"
        # "HDMI-A-1,1920x1080@60.0,0x0, 1.0, mirror, eDP-2"
        "DP-3,1920x1080@60.0,1925x0,1.0 " # , transform, 3"
        ",prefered,auto,1"
      ];

      cursor = {
        no_hardware_cursors = true;
        default_monitor = "eDP-2";
      };

      general = {
        resize_on_border = true;
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        border_part_of_window = true;
        layout = "master";
      };

      decoration = {
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        rounding = rounding;
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
        blur = {
          enabled = if blur then "true" else "false";
        };
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

    };
  };

}
