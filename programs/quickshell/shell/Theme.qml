import QtQuick

QtObject {
    property color bg: "#1e2326"
    property color bgAlt: "#24292d"
    property color fg: "#c0c5cc"
    property color fgDim: "#5c6670"
    property color accent: "#61afef"
    property color accentAlt: "#e5c07b"
    property color red: "#e06c75"
    property color green: "#98c379"
    property color yellow: "#e5c07b"
    property color blue: "#61afef"
    property color purple: "#c678dd"
    property color cyan: "#56b6c2"

    property int rounding: 8
    property string fontFamily: "SFProDisplay Nerd Font"
    property int fontSize: 13

    property color barBg: Qt.rgba(30/255, 35/255, 38/255, 0.92)
    property color moduleBg: Qt.rgba(40/255, 44/255, 48/255, 0.85)
    property color hoverBg: Qt.rgba(97/255, 175/255, 239/255, 0.15)

    property color batteryWarning: Qt.rgba(229/255, 192/255, 123/255, 0.2)
    property color batteryCritical: Qt.rgba(224/255, 108/255, 117/255, 0.2)
    property color batteryWarningFg: "#e5c07b"
    property color batteryCriticalFg: "#e06c75"

    property color separator: Qt.rgba(92/255, 102/255, 112/255, 0.4)

    property color popupBg: "#1e2326"
    property color popupInputBg: "#24292d"
    property color popupSelectedBg: "#61afef"
    property color popupSelectedFg: "#1e2326"
}
