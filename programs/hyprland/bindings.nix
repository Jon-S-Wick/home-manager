{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [

      # "$shiftMod, h, resizeactive,-50 0"
      # "$shiftMod, l, resizeactive,50 0"
      # "$shiftMod, k, resizeactive,0 -50"
      # "$shiftMod, j, resizeactive,0 50"

      "$shiftMod,h, movefocus, l" # Move focus left
      "$shiftMod,l, movefocus, r" # Move focus Right
      "$shiftMod,k, movefocus, u" # Move focus Up
      "$shiftMod,j, movefocus, d" # Move focus Down

      # "$shiftMod,h, focusmonitor, l" # Move focus left
      # "$shiftMod,l, focusmonitor, r" # Move focus Right
      # "$shiftMod,k, focusmonitor, u" # Move focus Up
      # "$shiftMod,j, focusmonitor, d" # Move focus Down

      "$ctrlMod,  h, movewindow, l"
      "$ctrlMod,  l, movewindow, r"
      "$ctrlMod,  k, movewindow, u"
      "$ctrlMod,  j, movewindow, d"

      # "$mod,RETURN, exec, ${pkgs.kitty}/bin/kitty" # Kitty
      "$mod,RETURN, exec, ${pkgs.ghostty}/bin/ghostty" # Kitty
      "$mod,T, exec, ${pkgs.thunar}/bin/thunar" # Thunar
      "$mod,V, exec, ${pkgs.vivaldi}/bin/vivaldi"
      "$mod,X, exec, powermenu" # Powermenu
      "$mod,SPACE, exec, menu" # Launcher
      "$shiftMod,C, exec, quickmenu" # Quickmenu
      "$shiftMod,SPACE, exec, hyprfocus-toggle" # Toggle HyprFocus
      # "$mod,TAB, overview:toggle" # Overview

      "$mod,Q, killactive," # Close window
      "$shiftMod,F, togglefloating," # Toggle Floating
      "$ctrlMod, P, pin, active"
      "$mod,F, fullscreen" # Toggle Fullscreen
      "$ctrlMod, F, fullscreenstate, 0 2"
      "$mod,left, movefocus, l" # Move focus left
      "$mod,right, movefocus, r" # Move focus Right
      "$mod,up, movefocus, u" # Move focus Up
      "$mod,down, movefocus, d" # Move focus Down
      "$shiftMod,up, focusmonitor, -1" # Focus previous monitor
      "$shiftMod,down, focusmonitor, 1" # Focus next monitor
      "$shiftMod,left, layoutmsg, addmaster" # Add to master
      "$shiftMod,right, layoutmsg, removemaster" # Remove from master

      "$mod,PRINT, exec, screenshot window" # Screenshot window
      ",PRINT, exec, screenshot monitor" # Screenshot monitor
      "$shiftMod,PRINT, exec, screenshot region" # Screenshot region
      "ALT,PRINT, exec, screenshot region swappy" # Screenshot region then edit

      "$mod,P, exec, screenshot region" # Screenshot region
      "$shiftMod, P, exec, screenshot monitor"

      # "$shiftMod,S, exec, ${pkgs.qutebrowser}/bin/qutebrowser :open $(wofi --show dmenu -L 1 -p ' Search on internet')" # Search on internet with wofi
      "$mod,C, exec, clipboard" # Clipboard picker with wofi
      "$shiftMod,E, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji" # Emoji picker with wofi
      "$mod,B, exec, bwmenu" # Bitwarden vault
      "$shiftMod,B, exec, changeblur" # Toggle blur
      "$mod,F2, exec, night-shift" # Toggle night shift
      "$mod,F3, exec, night-shift" # Toggle night shift
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod,code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9
    ));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # Play/Pause Song
      ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # Next Song
      ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # Previous Song
      ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock when closing Lid
      '', switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1,2560x1600@165.0,0x1080,1.6"''
      '',switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"''
    ];

    bindle = [
      ",XF86AudioRaiseVolume, exec, sound-up" # Sound Up
      ",XF86AudioLowerVolume, exec, sound-down" # Sound Down
      ",XF86MonBrightnessUp, exec, brightness-up" # Brightness Up
      ",XF86MonBrightnessDown, exec, brightness-down" # Brightness Down
    ];

  };
}
