{ pkgs, ... }:
let
  clamshell = pkgs.writeShellScriptBin "clamshell" ''
    LID_STATE=$(cat /proc/acpi/button/lid/LID/state 2>/dev/null | awk '{print $2}')

    # Get list of connected monitors
    MONITORS=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[].name')

    # Check if external monitors are connected (excluding eDP-*)
    EXTERNAL_MONITORS=$(echo "$MONITORS" | ${pkgs.gnugrep}/bin/grep -v "^eDP")

    if [ "$LID_STATE" = "closed" ]; then
        # Lid closed - disable internal display if external monitors exist
        if [ -n "$EXTERNAL_MONITORS" ]; then
            hyprctl keyword monitor "eDP-1, disable"
        fi
    else
        # Lid opened - re-enable internal display
        hyprctl keyword monitor "eDP-1,2560x1600@165.0,0x0,1.6"
    fi
  '';
in {
  home.packages = [ clamshell ];
}
