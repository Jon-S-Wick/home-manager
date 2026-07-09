{ pkgs, ... }:
let
  changeblur = pkgs.writeShellScriptBin "changeblur" ''
    STATE=$(hyprctl -j getoption decoration:blur:passes | ${pkgs.jq}/bin/jq ".int")

    if [ "''${STATE}" == "2" ]; then
      hyprctl keyword decoration:blur:size 2
      hyprctl keyword decoration:blur:passes 1
      ${pkgs.libnotify}/bin/notify-send -e -u low "Less blur"
    else
      hyprctl keyword decoration:blur:size 5
      hyprctl keyword decoration:blur:passes 2
      ${pkgs.libnotify}/bin/notify-send -e -u low "Normal blur"
    fi
  '';
in {
  home.packages = [ changeblur ];
}
