{ pkgs, ... }:
let
  changeblur = pkgs.writeShellScriptBin "changeblur" ''
    ENABLED=$(hyprctl -j getoption decoration:blur:enabled | ${pkgs.jq}/bin/jq ".int")
    PASSES=$(hyprctl -j getoption decoration:blur:passes | ${pkgs.jq}/bin/jq ".int")

    if [ "''${ENABLED}" == "0" ]; then
      hyprctl keyword decoration:blur:enabled true
      hyprctl keyword decoration:blur:size 2
      hyprctl keyword decoration:blur:passes 1
      ${pkgs.libnotify}/bin/notify-send -e -u low "Blur: low"
    elif [ "''${PASSES}" == "1" ]; then
      hyprctl keyword decoration:blur:size 5
      hyprctl keyword decoration:blur:passes 2
      ${pkgs.libnotify}/bin/notify-send -e -u low "Blur: medium"
    else
      hyprctl keyword decoration:blur:enabled false
      ${pkgs.libnotify}/bin/notify-send -e -u low "Blur: off"
    fi
  '';
in {
  home.packages = [ changeblur ];
}
