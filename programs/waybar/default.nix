{ pkgs, config, ... }:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  bg = "#${config.lib.stylix.colors.base00}";
  bg-alt = "#${config.lib.stylix.colors.base01}";
  fg = "#${config.lib.stylix.colors.base05}";
  rounding = config.var.theme.rounding;
  font = config.stylix.fonts.serif.name;

  # Workspace script - queries hyprctl for window classes and maps to icons
  workspaceScript = pkgs.writeScript "waybar-workspaces" ''
    #!/usr/bin/env python3
    import json, subprocess

    ICON_MAP = {
        "firefox": "󰈹",
        "google-chrome": "󰊯",
        "chromium-browser": "󰊯",
        "brave-browser": "󰖟",
        "vivaldi": "󰖟",
        "thunderbird": "󰇰",
        "code": "󰨞",
        "kitty": "󰄪",
        "foot": "󰄪",
        "alacritty": "󰄪",
        "wezterm": "󰄪",
        "ghostty": "󰄪",
        "nautilus": "󰉋",
        "thunar": "󰉋",
        "dolphin": "󰉋",
        "spotify": "󰓇",
        "discord": "󰙯",
        "teams-for-linux": "󰊻",
        "slack": "󰒲",
        "telegram-desktop": "󰊫",
        "signal": "󰭻",
        "obsidian": "󰋊",
        "libreoffice-writer": "󰈬",
        "libreoffice-calc": "󰈬",
        "libreoffice-impress": "󰈬",
        "libreoffice": "󰈬",
        "gimp": "󰊫",
        "inkscape": "󰊫",
        "blender": "󰊫",
        "vlc": "󰕼",
        "mpv": "󰕼",
        "imv": "󰊫",
        "file-roller": "󰉼",
        "pavucontrol": "󰓃",
        "blueman-manager": "󰂯",
        "nm-connection-editor": "󰤨",
        "virt-manager": "󰊫",
        "lutris": "󰊫",
        "steam": "󰓓",
        "jetbrains-idea": "󰅩",
        "jetbrains-studio": "󰅩",
        "jetbrains-pycharm": "󰅩",
        "jetbrains-webstorm": "󰅩",
        "jetbrains-rider": "󰅩",
        "jetbrains-clion": "󰅩",
        "jetbrains-goland": "󰅩",
        "jetbrains-datagrip": "󰅩",
        "jetbrains-phpstorm": "󰅩",
        "jetbrains-rubymine": "󰅩",
        "jetbrains-appcode": "󰅩",
        "jetbrains-cidrwebserver": "󰅩",
        "jetbrains-cidrdebugger": "󰅩",
        "jetbrains-cidreditor": "󰅩",
        "jetbrains-ideservices": "󰅩",
        "jetbrains-product-catalog": "󰅩",
        "jetbrains-marketplace": "󰅩",
        "jetbrains-account": "󰅩",
        "jetbrains-clouds": "󰅩",
        "jetbrains-decompiler": "󰅩",
        "jetbrains-docker": "󰅩",
        "jetbrains-editorconfig": "󰅩",
        "jetbrains-gradle": "󰅩",
        "jetbrains-groovy": "󰅩",
        "jetbrains-gradle-dsl": "󰅩",
        "jetbrains-maven": "󰅩",
        "jetbrains-perl5": "󰅩",
        "jetbrains-php": "󰅩",
        "jetbrains-pyycharm": "󰅩",
        "jetbrains-rest": "󰅩",
        "jetbrains-ruby": "󰅩",
        "jetbrains-scala": "󰅩",
        "jetbrains-shell-script": "󰅩",
        "jetbrains-sql": "󰅩",
        "jetbrains-typescript": "󰅩",
        "jetbrains-uml": "󰅩",
        "jetbrains-xml": "󰅩",
        "jetbrains-yaml": "󰅩",
        "rider": "󰅩",
        "pycharm": "󰅩",
        "idea": "󰅩",
        "webstorm": "󰅩",
        "clion": "󰅩",
        "goland": "󰅩",
        "datagrip": "󰅩",
        "phpstorm": "󰅩",
        "rubymine": "󰅩",
        "appcode": "󰅩",
        "wps-office": "󰈬",
        "wpsoffice": "󰈬",
        "zotero": "󰎧",
        "obs": "󰑨",
        "zoom": "󰍱",
        "default": "󰊯",
    }

    def to_subscript(n):
        sub = "₀₁₂₃₄₅₆₇₈₉"
        return "".join(sub[int(d)] for d in str(n))

    def get_icon(cls):
        cls_lower = cls.lower()
        for key, icon in ICON_MAP.items():
            if key in cls_lower:
                return icon
        return ICON_MAP["default"]

    try:
        workspaces = json.loads(subprocess.check_output(["hyprctl", "workspaces", "-j"], timeout=2))
    except:
        workspaces = []
    try:
        clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"], timeout=2))
    except:
        clients = []
    try:
        active = json.loads(subprocess.check_output(["hyprctl", "activeworkspace", "-j"], timeout=2))["id"]
    except:
        active = -1

    ws_clients = {}
    for c in clients:
        wid = c["workspace"]["id"]
        if wid < 0:
            continue
        ws_clients.setdefault(wid, []).append(c)

    result = []
    for ws in workspaces:
        wid = ws["id"]
        if wid < 0:
            continue
        cls_list = ws_clients.get(wid, [])
        icons = []
        for c in cls_list:
            ico = get_icon(c["class"])
            if ico not in icons:
                icons.append(ico)
        icon_str = "".join(icons) if icons else "󰋜"
        label = icon_str + to_subscript(wid)
        tooltip_parts = [c["title"][:40] for c in cls_list if c.get("title")]
        tooltip = f"Workspace {wid}" + (": " + ", ".join(tooltip_parts) if tooltip_parts else "")

        result.append({
            "id": wid,
            "name": label,
            "active": wid == active,
            "focused": wid == active,
            "windows": len(cls_list),
            "tooltip": tooltip,
        })

    result.sort(key=lambda x: x["id"])
    print(json.dumps(result))
  '';

  audioPopup = pkgs.writeShellScript "waybar-audio-popup" ''
    #!/bin/bash
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o '\[MUTED\]')

    if [ -n "$muted" ]; then
      options="󰕾  Unmute\n─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n󰝟  Volume: $volume%"
    else
      options="󰖁  Mute\n󰕾  Vol -5\n󰕾  Vol +5\n─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n󰝟  Volume: $volume%"
    fi

    sinks=$(wpctl status | sed -n '/Audio sinks/,/^$/p' | tail -n +2 | head -n -1)
    if [ -n "$sinks" ]; then
      options="$options\n─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n󰓃  Sinks:"
      while IFS= read -r line; do
        if echo "$line" | grep -q '\*'; then
          name=$(echo "$line" | sed 's/.*\*\s*//' | sed 's/\s*.*//')
          options="$options\n    ◉ $name"
        else
          name=$(echo "$line" | sed 's/.*[0-9]\.\s*//' | sed 's/\s*.*//')
          options="$options\n    ◌ $name"
        fi
      done <<< "$sinks"
    fi

    chosen=$(echo -e "$options" | wofi --dmenu \
      --prompt "" \
      --width 300 \
      --height 300 \
      --style "
        window { background-color: ${bg}; border-radius: ${toString rounding}px; }
        #outer-box { padding: 12px; }
        #input { background-color: ${bg-alt}; color: ${fg}; padding: 8px; border-radius: ${toString rounding}px; font-family: '${font}'; font-size: 13px; }
        #entry { padding: 6px 8px; font-family: '${font}'; font-size: 13px; }
        #entry:selected { background-color: ${accent}; color: ${bg}; border-radius: ${toString rounding}px; }
        #text { color: ${fg}; }
        #text:selected { color: ${bg}; }
      ")

    case "$chosen" in
      *"Unmute"*) wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ;;
      *"Mute"*) wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 ;;
      *"Vol -5"*) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
      *"Vol +5"*) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ 2>/dev/null ;;
    esac
  '';

  bluetoothPopup = pkgs.writeShellScript "waybar-bluetooth-popup" ''
    #!/bin/bash
    bt_state=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

    if [ "$bt_state" = "yes" ]; then
      options="󰂲  Turn Off\n─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n󰂱  Paired Devices:"

      devices=$(bluetoothctl devices Paired 2>/dev/null)
      if [ -n "$devices" ]; then
        while IFS= read -r line; do
          name=$(echo "$line" | cut -d' ' -f3-)
          mac=$(echo "$line" | awk '{print $2}')
          info=$(bluetoothctl info "$mac" 2>/dev/null)
          if echo "$info" | grep -q "Connected: yes"; then
            options="$options\n    ◉ $name"
          else
            options="$options\n    ◌ $name"
          fi
        done <<< "$devices"
      fi
    else
      options="󰂯  Turn On"
    fi

    chosen=$(echo -e "$options" | wofi --dmenu \
      --prompt "" \
      --width 300 \
      --height 300 \
      --style "
        window { background-color: ${bg}; border-radius: ${toString rounding}px; }
        #outer-box { padding: 12px; }
        #input { background-color: ${bg-alt}; color: ${fg}; padding: 8px; border-radius: ${toString rounding}px; font-family: '${font}'; font-size: 13px; }
        #entry { padding: 6px 8px; font-family: '${font}'; font-size: 13px; }
        #entry:selected { background-color: ${accent}; color: ${bg}; border-radius: ${toString rounding}px; }
        #text { color: ${fg}; }
        #text:selected { color: ${bg}; }
      ")

    case "$chosen" in
      *"Turn On"*) bluetoothctl power on ;;
      *"Turn Off"*) bluetoothctl power off ;;
    esac
  '';

  wifiPopup = pkgs.writeShellScript "waybar-wifi-popup" ''
    #!/bin/bash
    wifi_state=$(nmcli radio wifi)

    if [ "$wifi_state" = "enabled" ]; then
      current=$(nmcli -t -f active,ssid dev wifi | grep '^yes:' | cut -d: -f2)

      options="󰤭  Turn Off Wi-Fi\n─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n󰤨  Available Networks:"

      networks=$(nmcli -t -f signal,ssid dev wifi | sort -rn)
      while IFS= read -r line; do
        signal=$(echo "$line" | cut -d: -f1)
        ssid=$(echo "$line" | cut -d: -f2-)
        if [ -z "$ssid" ]; then continue; fi
        if [ "$ssid" = "$current" ]; then
          options="$options\n    ◉ $ssid ($signal%)"
        else
          options="$options\n    ◌ $ssid ($signal%)"
        fi
      done <<< "$networks"
    else
      options="󰤨  Turn On Wi-Fi"
    fi

    chosen=$(echo -e "$options" | wofi --dmenu \
      --prompt "" \
      --width 350 \
      --height 350 \
      --style "
        window { background-color: ${bg}; border-radius: ${toString rounding}px; }
        #outer-box { padding: 12px; }
        #input { background-color: ${bg-alt}; color: ${fg}; padding: 8px; border-radius: ${toString rounding}px; font-family: '${font}'; font-size: 13px; }
        #entry { padding: 6px 8px; font-family: '${font}'; font-size: 13px; }
        #entry:selected { background-color: ${accent}; color: ${bg}; border-radius: ${toString rounding}px; }
        #text { color: ${fg}; }
        #text:selected { color: ${bg}; }
      ")

    case "$chosen" in
      *"Turn On"*) nmcli radio wifi on ;;
      *"Turn Off"*) nmcli radio wifi off ;;
    esac
  '';

  audioScript = pkgs.writeShellScript "waybar-audio-json" ''
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "true" || echo "false")
    if [ "$muted" = "true" ]; then
      echo '{"text": "󰝟", "tooltip": "Muted", "class": "muted"}'
    elif [ "$volume" -lt 30 ]; then
      echo '{"text": "󰕿", "tooltip": "Volume: '"$volume"'%", "class": "low"}'
    elif [ "$volume" -lt 70 ]; then
      echo '{"text": "󰖀", "tooltip": "Volume: '"$volume"'%", "class": "medium"}'
    else
      echo '{"text": "󰕾", "tooltip": "Volume: '"$volume"'%", "class": "high"}'
    fi
  '';

  bluetoothScript = pkgs.writeShellScript "waybar-bluetooth-json" ''
    powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')
    connected=$(bluetoothctl info 2>/dev/null | grep "Connected: yes" | wc -l)
    if [ "$powered" != "yes" ]; then
      echo '{"text": "󰂲", "tooltip": "Off", "class": "off"}'
    elif [ "$connected" -gt 0 ]; then
      echo '{"text": "󰂱", "tooltip": "Connected", "class": "connected"}'
    else
      echo '{"text": "󰂯", "tooltip": "On", "class": "on"}'
    fi
  '';
in
{
  home.packages = [
    pkgs.wttrbar
    pkgs.waybar-mpris
    pkgs.blueman
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "8 12 0 12";
        height = 36;
        spacing = 4;

        modules-left = [
          "custom/workspaces"
          "hyprland/language"
          "wlr/taskbar"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/audio"
          "custom/bluetooth"
          "network"
          "battery"
          "tray"
        ];

        "custom/workspaces" = {
          format = "{name}";
          return-type = "json";
          exec = "${workspaceScript}";
          on-click = "activate";
          sort-by-number = true;
          active-only = false;
          tooltip = true;
          interval = 1;
        };

        "hyprland/language" = {
          format-en = "US";
          format-ru = "RU";
          min-length = 5;
          tooltip = false;
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%a; %d %b, %I:%M %p}";
        };

        "custom/audio" = {
          format = "{}";
          return-type = "json";
          exec = "${audioScript}";
          on-click = "${audioPopup}";
          tooltip = false;
          interval = 1;
        };

        "custom/bluetooth" = {
          format = "{}";
          return-type = "json";
          exec = "${bluetoothScript}";
          on-click = "${bluetoothPopup}";
          tooltip = false;
          interval = 5;
        };

        "network" = {
          format-wifi = "󰤨 ";
          format-ethernet = "󰈀 ";
          format-disconnected = "󰤭 ";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          on-click = "${wifiPopup}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰁄";
          format-plugged = "{capacity}% 󰂄";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "SFProDisplay Nerd Font", "Noto Color Emoji", sans-serif;
          font-weight: 600;
          min-height: 0;
      }

      window#waybar {
          background: rgba(30, 35, 30, 0.85);
          color: #d4c7aa;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /* Workspaces */
      #custom-workspaces {
          margin: 4px 4px 4px 8px;
          padding: 0 4px;
          border-radius: 10px;
          background: rgba(50, 55, 50, 0.9);
      }

      #custom-workspaces button {
          padding: 0 8px;
          color: #859289;
          font-size: 14px;
          min-width: 18px;
          border-radius: 8px;
          margin: 2px;
          transition: all 0.2s ease;
      }

      #custom-workspaces button:hover {
          background: rgba(133, 146, 137, 0.3);
          color: #d4c7aa;
      }

      #custom-workspaces button.active {
          background: #a7c080;
          color: #2d3530;
          font-weight: 700;
      }

      #custom-workspaces button.urgent {
          background: #e67e80;
          color: #2d3530;
      }

      /* Language */
      #language {
          margin: 4px 0;
          padding: 0 12px;
          border-radius: 10px;
          color: #d4c7aa;
          background: rgba(50, 55, 50, 0.9);
          font-size: 12px;
      }

      /* Taskbar */
      #taskbar {
          margin: 4px 8px;
          padding: 0 8px;
          border-radius: 10px;
          background: rgba(50, 55, 50, 0.9);
      }

      #taskbar button {
          padding: 0 8px;
          margin: 2px;
          border-radius: 8px;
          color: #859289;
          transition: all 0.2s ease;
      }

      #taskbar button.active {
          background: #a7c080;
          color: #2d3530;
      }

      /* Clock */
      #clock {
          margin: 4px 8px;
          padding: 0 16px;
          border-radius: 10px;
          color: #d4c7aa;
          background: rgba(50, 55, 50, 0.9);
          font-size: 13px;
      }

      /* Custom modules (audio, bluetooth) */
      #custom-audio,
      #custom-bluetooth,
      #network,
      #battery,
      #tray {
          margin: 4px 2px;
          padding: 0 10px;
          border-radius: 10px;
          background: rgba(50, 55, 50, 0.9);
          color: #d4c7aa;
          font-size: 15px;
      }

      #custom-audio:hover,
      #custom-bluetooth:hover,
      #network:hover {
          background: rgba(167, 192, 128, 0.3);
          color: #a7c080;
      }

      #custom-audio.muted {
          color: #859289;
      }

      #custom-bluetooth.off {
          color: #859289;
      }

      #network {
          font-size: 15px;
      }

      /* Battery */
      #battery {
          font-size: 12px;
      }

      #battery.charging {
          color: #a7c080;
      }

      #battery.warning:not(.charging) {
          background: rgba(219, 170, 105, 0.3);
          color: #dbaa69;
      }

      #battery.critical:not(.charging) {
          background: rgba(230, 126, 128, 0.3);
          color: #e67e80;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* Tray */
      #tray {
          margin: 4px 8px 4px 2px;
          padding: 0 10px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background: rgba(230, 126, 128, 0.3);
      }

      @keyframes blink {
          to {
              background: rgba(230, 126, 128, 0.5);
              color: #e67e80;
          }
      }
    '';
  };
}
