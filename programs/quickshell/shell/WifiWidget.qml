import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

Item {
    id: wifiWidget
    implicitWidth: wifiIcon.implicitWidth + 16
    implicitHeight: 28

    property var theme

    Rectangle {
        anchors.fill: parent
        radius: theme.rounding
        color: parent.containsMouse ? theme.hoverBg : theme.moduleBg

        Text {
            id: wifiIcon
            anchors.centerIn: parent
            property bool wifiEnabled: Networking.wifiEnabled

            text: wifiEnabled ? "\ufc48" : "\ufc4b"
            color: wifiEnabled ? theme.fg : theme.fgDim
            font { family: theme.fontFamily; pixelSize: 14 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
        }
    }
}
