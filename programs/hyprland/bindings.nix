{ pkgs, lib, ... }:
{
  services.playerctld.enable = true;

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + h"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = -50, y = 0, relative = true })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + l"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 50, y = 0, relative = true })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + k"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = -50, relative = true })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + j"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = 50, relative = true })'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + h"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + l"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + k"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + j"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + h"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "left" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + l"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "right" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + k"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "up" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + j"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "down" })'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + RETURN"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.ghostty}/bin/ghostty")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + T"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.thunar}/bin/thunar")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + V"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.vivaldi}/bin/vivaldi")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + X"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle session")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + SPACE"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + SPACE"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprfocus-toggle")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + Q"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.close()'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + F"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + P"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.pin({ action = "toggle" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + F"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen()'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''ctrlMod .. " + F"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen_state({ internal = 0, client = 2 })'')
        ];
      }
      {
        _args = [
          "SUPER + left"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
        ];
      }
      {
        _args = [
          "SUPER + right"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
        ];
      }
      {
        _args = [
          "SUPER + up"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
        ];
      }
      {
        _args = [
          "SUPER + down"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + up"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ monitor = "-1" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + down"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ monitor = "+1" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + left"'')
          (lib.generators.mkLuaInline ''hl.dsp.layout("addmaster")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + right"'')
          (lib.generators.mkLuaInline ''hl.dsp.layout("removemaster")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + PRINT"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot window")'')
        ];
      }
      {
        _args = [
          "PRINT"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot monitor")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + PRINT"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot region")'')
        ];
      }
      {
        _args = [
          "ALT + PRINT"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot region swappy")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + P"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot region")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + P"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("screenshot monitor")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + C"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + E"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher \"/emo\"")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + B"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher \"/bw\"")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''shiftMod .. " + B"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("changeblur")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + F2"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("night-shift")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + F3"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("night-shift")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + mouse:272"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.drag()'')
          { mouse = true; }
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + R"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.resize()'')
          { mouse = true; }
        ];
      }

      {
        _args = [
          "XF86AudioMute"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-mute")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioPlay"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl --player=playerctld play-pause")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioNext"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl --player=playerctld next")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioPrev"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl --player=playerctld previous")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mod .. " + m"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl --player=playerctld shift")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "switch:Lid Switch"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("clamshell")'')
          { locked = true; }
        ];
      }

      {
        _args = [
          "XF86AudioRaiseVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-up")'')
          { locked = true; repeating = true; }
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-down")'')
          { locked = true; repeating = true; }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg brightness-up")'')
          { locked = true; repeating = true; }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg brightness-down")'')
          { locked = true; repeating = true; }
        ];
      }
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          {
            _args = [
              "SUPER + code:1${toString i}"
              (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = ${toString ws} })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + code:1${toString i}"
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = ${toString ws} })'')
            ];
          }
        ]
      ) 9
    ));
  };
}
