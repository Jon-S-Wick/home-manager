import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: trayWidget
    spacing: 6

    property var theme

    Repeater {
        model: SystemTray.items

        Item {
            implicitWidth: 20
            implicitHeight: 20

            Image {
                anchors.centerIn: parent
                source: modelData.icon ?? ""
                width: 16
                height: 16
                sourceSize: Qt.size(16, 16)
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: function(mouse) {
                    if (mouse.button === Qt.RightButton) {
                        modelData.activate();
                    }
                }
            }
        }
    }
}
