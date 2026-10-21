import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: workspaces
    spacing: 3

    property var theme

    Repeater {
        model: 10

        Rectangle {
            id: wsButton
            property int wsId: index + 1
            property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)
            property bool isActive: Hyprland.focusedWorkspace?.id === wsId
            property bool hasWindows: ws !== undefined && ws !== null

            width: wsLabel.implicitWidth + 14
            height: 22
            radius: theme.rounding
            color: isActive ? theme.accent : (hasWindows ? theme.moduleBg : "transparent")

            Text {
                id: wsLabel
                anchors.centerIn: parent
                text: wsButton.wsId
                color: isActive ? theme.bg : (wsButton.hasWindows ? theme.fg : theme.fgDim)
                font { family: theme.fontFamily; pixelSize: 11; bold: wsButton.isActive }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + wsButton.wsId)
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
