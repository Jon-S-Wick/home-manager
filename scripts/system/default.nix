# - ## System
#- 
#- Usefull quick scripts
#-
#- - `menu` - Open wofi with drun mode. (wofi)
#- - `powermenu` - Open power dropdown menu. (wofi)
#- - `lock` - Lock the screen. (noctalia)
{ pkgs, ... }:

let
  menu = pkgs.writeShellScriptBin "menu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      else
      	wofi -p " Apps" --show drun
      fi
      # if pgrep tofi; then
      # 	pkill tofi
      # else
      # 	tofi-drun --drun-launch=true
      # fi
    '';

  powermenu = pkgs.writeShellScriptBin "powermenu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      # if pgrep tofi; then
      #   pkill tofi
      else
        options=(
          "󰌾 Lock"
          "󰍃 Logout"
          " Suspend"
          "󰑐 Reboot"
          "󰿅 Shutdown"
        )

        selected=$(printf '%s\n' "''${options[@]}" | wofi -p " Powermenu" --dmenu)
        # selected=$(printf '%s\n' "''${options[@]}" | tofi --prompt-text "> ")
        selected=''${selected:2}

        case $selected in
          "Lock")
            noctalia msg session lock
            ;;
          "Logout")
            hyprctl dispatch exit
            ;;
          "Suspend")
            chvt 63 && systemctl suspend
            ;;
          "Reboot")
            systemctl reboot
            ;;
          "Shutdown")
            systemctl poweroff
            ;;
        esac
      fi
    '';

  quickmenu = pkgs.writeShellScriptBin "quickmenu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      # if pgrep tofi; then
      #   pkill tofi
      else
        options=(
          "󰅶 Caffeine"
          "󰖔 Night-shift"
          " Nixy"
          "󰈊 Hyprpicker"
          "📋 Clipboard"
          
        )

        selected=$(printf '%s\n' "''${options[@]}" | wofi -p " Quickmenu" --dmenu)
        # selected=$(printf '%s\n' "''${options[@]}" | tofi --prompt-text "> ")
        selected=''${selected:2}

        case $selected in
          "Caffeine")
            caffeine
            ;;
          "Night-shift")
            night-shift
            ;;
          "Nixy")
            kitty zsh -c nixy
            ;;
          "Hyprpicker")
            sleep 0.2 && ${pkgs.hyprpicker}/bin/hyprpicker -a
            ;;
          "Clipboard")
              sleep 0.2 && clipboard
            ;;
        esac
      fi
    '';

  lock = pkgs.writeShellScriptBin "lock"
    # bash
    ''
      noctalia msg session lock
    '';

  search = pkgs.writeShellScriptBin "search"
    # bash
    ''
      if pgrep wofi; then
        pkill wofi
      else
        wofi -p " Search" --show dmenu
      fi
    '';

  bwmenu = pkgs.writeShellScriptBin "bwmenu"
    # bash
    ''
      if pgrep wofi; then
        pkill wofi
      else
        entry=$(${pkgs.rbw}/bin/rbw list | wofi -p " Bitwarden" --dmenu)
        if [ -n "$entry" ]; then
          password=$(${pkgs.rbw}/bin/rbw get password "$entry")
          echo -n "$password" | wl-copy
          notify-send "Bitwarden" "Password for $entry copied to clipboard"
        fi
      fi
    '';

in { home.packages = [ menu powermenu lock quickmenu search bwmenu ]; }
