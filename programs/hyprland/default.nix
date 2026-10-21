{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

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
    # ./waybar.nix
    ./../waybar/default.nix
    # ./hyprlock.nix
    # ./hyprdynamicmonitors.nix
    ./monique.nix
    # ./hyprpanel.nix
  ];
  # programs.hyprpanel.enable = true;

  home.packages = with pkgs; [
    # qt5.qtwayland
    # qt6.qtwayland
    # libsForQt5.qt5ct
    # qt6ct
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
    xwayland.enable = true;
    # systemd.enable = true;

    # Hyprland 0.56.2 (the newest release nixpkgs has) segfaults in
    # CWorkspace::isVisibleNotCovered(), which dereferences the raw
    # CMonitor::m_activeWorkspace pointer without a null check. A monitor
    # being torn down leaves it null, and CLayerSurface::onUnmap ->
    # CInputManager::refocusLastWindow hits it.
    #
    # Upstream fixed it in the workspace-handling refactor (#16140) by making
    # m_activeWorkspace a shared pointer and comparing pointers instead of
    # dereferencing. That is unreleased, so track upstream main instead.
    #
    # The input is pinned to a specific commit in flake.nix on purpose: main is
    # unreleased and can break, so bump it deliberately rather than letting it
    # float. The overlay only overrides `package`, so the rest of the session
    # (noctalia, xdg-desktop-portal-hyprland, ...) stays on stable nixpkgs.

    # exec-once = qs;
    # exec-once = kdeconnect-indicator;
    # exec-once = "thunderbird --headless";
    # env = "XDG_SESSION_TYPE,wayland
    #
    #
    # env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    extraConfig = ''
      dofile("${config.home.homeDirectory}/.config/hypr/monitors.lua")
    '';

    settings = {

      mod = {
        _var = "SUPER";
      };

      shiftMod = {
        _var = "SUPER + SHIFT";
      };

      ctrlMod = {
        _var = "SUPER + CTRL";
      };

      # monitor = [ ]; # monitors are managed at runtime by monique (sourced monitors.lua)

      config = {
        cursor = {
          # no_hardware_cursors = true;
          default_monitor = "HDMI-A-1";
        };

        general = {
          resize_on_border = true;
          gaps_in = gaps-in;
          gaps_out = gaps-out;
          border_size = border-size;
          # border_part_of_window = true;
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
            # color = lib.mkForce "rgba(00000055)";
          };
          blur = {
            enabled = blur;
            size = 3;
            passes = 1;
            new_optimizations = true;
            ignore_opacity = false;
          };
        };

        master = {
          new_status = "master";
          allow_small_split = true;
          mfact = 0.5;
        };

        misc = {
          # vfr = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          disable_autoreload = false;
          focus_on_activate = true;
          animate_mouse_windowdragging = true;
          enable_swallow = true;
          # new_window_takes_over_fullscreen = 2;
        };
      };

      layer_rule = [
        {
          name = "blur-gtk-layer-shell";
          match = {
            namespace = "gtk-layer-shell";
          };
          blur = true;
        }
        {
          name = "blur-notifications";
          match = {
            namespace = "notifications";
          };
          blur = true;
        }
        {
          name = "blur-wofi";
          match = {
            namespace = "wofi";
          };
          blur = true;
        }
        {
          name = "blur-rofi";
          match = {
            namespace = "rofi";
          };
          blur = true;
        }
        {
          name = "blur-power-menu";
          match = {
            namespace = "power-menu";
          };
          blur = true;
        }
        {
          name = "blur-anyrun";
          match = {
            namespace = "anyrun";
          };
          blur = true;
        }
      ];

    };
  };

}
