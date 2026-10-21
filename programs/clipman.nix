# Clipman allows you to save and retrieve clipboard history.
{ pkgs, lib, ... }:
let
  clipboard-clear = pkgs.writeShellScriptBin "clipboard-clear" ''
    clipman clear --all
  '';

  clipboard = pkgs.writeShellScriptBin "clipboard" ''
    clipman pick --tool=wofi
  '';

in
{
  wayland.windowManager.hyprland.settings.on = [
    {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''function()
  hl.exec_cmd("${clipboard-clear}/bin/clipboard-clear")
  hl.exec_cmd("wl-paste -t text --watch clipman store")
end'')
      ];
    }
  ];
  home.packages = with pkgs; [
    clipman
    clipboard
    clipboard-clear
  ];
  services.clipman.enable = true;
}
