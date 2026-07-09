{
  pkgs,
  config,
  ...
}:
let
  fontSize = "10px";
  iconSize = "12px";
  opacity = "0.8";
  palette = {
    font = "RobotoMono Nerd Font";
    fontsize = fontSize;
    iconsize = iconSize;
    background-color = "rgba(39, 39, 39, ${opacity})";
    background = "#${config.lib.stylix.colors.base00}";
    foreground = "#${config.lib.stylix.colors.base05}";
    background-alt = "#${config.lib.stylix.colors.base01}";
    accent = "#${config.lib.stylix.colors.base0D}";
    dark = "#434343";
    red = "#c94f6d";
    yellow = "#dbc074";
    blue = "#719cd6";
  };
  calendar = "${pkgs.gnome-calendar}/bin/gnome-calendar";
  system = "${pkgs.gnome-system-monitor}/bin/gnome-system-monitor";
in
{
  home.packages = [
    pkgs.wttrbar
    pkgs.waybar-mpris
    pkgs.libnotify
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings.mainBar = {
      position = "top";
      layer = "top";
      height = 20;
      margin-top = 3;
      margin-bottom = 2;
      margin-left = 4;
      margin-right = 4;
      modules-left = [
        "group/pill#left"
        "hyprland/workspaces"
        "wlr/taskbar"
      ];
      modules-center = [
        "clock"
        "custom/wttr"
      ];
      modules-right = [
        "tray"
        "temperature"
        # "cpu"
        "battery"
        # "memory"
        "pulseaudio"
        "network"
        "custom/notification"
      ];
      "group/pill-left" = {
        orientation = "inherit";
        modules = [
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon}<span><sup>{0}</sup></span>";
        format-icons = {
          notification = "";
          none = "";
          dnd-notification = "";
          dnd-none = "";
          inhibited-notification = "";
          inhibited-none = "";
          dnd-inhibited-notification = "";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      "group/pill#center" = {
        orientation = "inherit";
        modules = [
          "clock"
          "custom/wttr"
        ];
      };
      clock = {
        format = " {:%a, %d %b, %I:%M %p}";
        tooltip = "true";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = " {:%d/%m}";
        on-click = "${calendar}";
      };
      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = " {capacity}% ";
        format-alt = "{icon} {time}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
      temperature = {
        critical = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [
          ""
          ""
          ""
        ];

      };
      memory = {
        format = "󰍛 {}%";
        format-alt = "󰍛 {used}/{total} GiB";
        on-click = "${system}";
        interval = 5;
      };
      cpu = {
        format = "󰻠 {usage}%";
        format-alt = "󰻠 {avg_frequency} GHz";
        on-click = "${system}";
        interval = 5;
      };
      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "󰈀 100% ";
        tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰖪 0% ";
      };
      tray = {
        icon-size = 20;
        spacing = 8;
      };
      "custom/wttr" = {
        exec = "wttrbar";
        interval = 600;
        return-type = "json";
        format = "{}C°";

      };
      pulseaudio = {
        format = "{volume}% {icon}";
        format-muted = "󰝟";
        format-bluetooth = "{volume}% {icon}";
        format-icons = {
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
        };
        scroll-step = 5;
        on-click = "pwvucontrol";
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: ${palette.font};
          font-size: ${palette.fontsize};
          min-height: 0;
      }


      window#waybar {
        background: rgba(20, 30, 40, 0.0); /* black with 30% opacity */
        color: #ffffff;
        border: none;
      }.modules-right {
        margin: 2px 10px 0 0;
         border-radius: 10px;
        background-color: ${palette.background};
      }.modules-center {

        margin: 2px 10px 0 0;
         border-radius: 10px;
        background-color: ${palette.background};
      }
      /*
      window > box {
         margin-left: 5px;
         margin-right: 5px;
         margin-top: 5px;
         background-color: ${palette.background};
         border: 2px none ${palette.background};
      } */


      #workspaces {
         background: ${palette.background};
         color: ${palette.background};
         margin: 3px 3px;
         padding: 3px 2px;
      }
      #workspaces button {
         background: ${palette.background};
         color: ${palette.foreground};
         padding: 0px 0px;
         transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
         background-color: ${palette.accent};
         color: ${palette.background};
         background-size: 150% 150%;
         border-radius: 3px;
         transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
         background-color: ${palette.background-alt};
         color: ${palette.foreground};
         background-size: 400% 400%;
      }

      #workspaces button.urgent {
         background-color: ${palette.red};
         color: ${palette.foreground};
      }


      #mode, #clock, #memory, #temperature,#cpu, #temperature, #pulseaudio, #network, #battery {
         padding-left: 7px;
         padding-right: 7px;
      }

      #tray {
         padding-right: 28px;
         padding-left: 10px;
      }
    '';
  };
}
