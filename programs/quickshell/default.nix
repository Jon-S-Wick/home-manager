{ pkgs, config, ... }:

let
  accent = "#${config.lib.stylix.colors.base0D}";
  bg = "#${config.lib.stylix.colors.base00}";
  bgAlt = "#${config.lib.stylix.colors.base01}";
  fg = "#${config.lib.stylix.colors.base05}";
  rounding = config.var.theme.rounding;
  font = config.stylix.fonts.serif.name;

  shellDir = ./shell;
in
{
  home.packages = [ pkgs.quickshell ];

  xdg.configFile."quickshell" = {
    source = shellDir;
    recursive = true;
  };

  xdg.configFile."quickshell/shell.qml".text = ''
    import Quickshell
    import QtQuick

    ShellRoot {
        Theme {
            id: theme
            bg: "${bg}"
            bgAlt: "${bgAlt}"
            fg: "${fg}"
            fgDim: "#5c6670"
            accent: "${accent}"
            accentAlt: "#e5c07b"
            red: "#e06c75"
            green: "#98c379"
            yellow: "#e5c07b"
            blue: "${accent}"
            purple: "#c678dd"
            cyan: "#56b6c2"
            rounding: ${toString rounding}
            fontFamily: "${font}"
            fontSize: 13
        }

        Variants {
            model: Quickshell.screens

            PanelWindow {
                id: toplevel
                property var modelData: modelData
                screen: modelData

                anchors.top: true
                anchors.left: true
                anchors.right: true
                implicitHeight: 36
                color: theme.barBg

                Bar {
                    anchors.fill: parent
                    anchors.margins: 4
                    theme: theme
                }
            }
        }
    }
  '';
}
