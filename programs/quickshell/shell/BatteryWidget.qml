import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Item {
    id: batteryWidget
    implicitWidth: batteryLabel.implicitWidth + 16
    implicitHeight: 28

    property var theme

    Rectangle {
        anchors.fill: parent
        radius: theme.rounding
        color: theme.moduleBg

        Text {
            id: batteryLabel
            anchors.centerIn: parent

            property var device: UPower.displayDevice
            property real pct: device?.percentage ?? 0
            property bool charging: device?.state === 1
            property bool isLaptop: device?.isLaptopBattery ?? false

            visible: isLaptop
            text: {
                var icons = ["\ufc19", "\ufc1a", "\ufc1b", "\ufc1c", "\ufc1d",
                            "\ufc1e", "\ufc1f", "\ufc20", "\ufc21", "\ufc22"];
                var idx = Math.min(Math.floor(pct / 10), 9);
                var icon = icons[idx];
                if (charging) icon = "\ufc44";
                return Math.round(pct) + "% " + icon;
            }
            color: {
                if (!charging && pct <= 15) return theme.batteryCriticalFg;
                if (!charging && pct <= 30) return theme.batteryWarningFg;
                if (charging) return theme.green;
                return theme.fg;
            }
            font { family: theme.fontFamily; pixelSize: 12; bold: true }
        }
    }
}
