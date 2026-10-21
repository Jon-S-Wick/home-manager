import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

Item {
    id: btWidget
    implicitWidth: btIcon.implicitWidth + 16
    implicitHeight: 28

    property var theme

    Rectangle {
        anchors.fill: parent
        radius: theme.rounding
        color: parent.containsMouse ? theme.hoverBg : theme.moduleBg

        Text {
            id: btIcon
            anchors.centerIn: parent
            property bool enabled: Bluetooth.defaultAdapter?.enabled ?? false
            property bool hasConnected: {
                if (!Bluetooth.defaultAdapter) return false;
                for (var i = 0; i < Bluetooth.defaultAdapter.devices.count; i++) {
                    var dev = Bluetooth.defaultAdapter.devices.get(i);
                    if (dev.connected) return true;
                }
                return false;
            }

            text: !enabled ? "\ufc33"
                : hasConnected ? "\ufc31"
                : "\ufc32"
            color: !enabled ? theme.fgDim : theme.fg
            font { family: theme.fontFamily; pixelSize: 14 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                var adapter = Bluetooth.defaultAdapter;
                if (adapter) adapter.enabled = !adapter.enabled;
            }
        }
    }
}
