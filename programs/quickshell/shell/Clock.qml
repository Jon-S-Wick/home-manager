import Quickshell
import QtQuick

Rectangle {
    id: clock
    implicitWidth: clockLabel.implicitWidth + 16
    implicitHeight: 28
    radius: theme.rounding
    color: theme.moduleBg

    property var theme

    Text {
        id: clockLabel
        anchors.centerIn: parent
        property var timer: new Date()
        color: theme.fg
        font { family: theme.fontFamily; pixelSize: 12; bold: true }
        text: Qt.formatDateTime(timer, "ddd  dd MMM  hh:mm AP")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockLabel.timer = new Date()
        }
    }
}
