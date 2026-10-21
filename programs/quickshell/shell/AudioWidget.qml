import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Item {
    id: audioWidget
    implicitWidth: audioIcon.implicitWidth + 16
    implicitHeight: 28

    property var theme

    Rectangle {
        anchors.fill: parent
        radius: theme.rounding
        color: parent.containsMouse ? theme.hoverBg : theme.moduleBg

        Text {
            id: audioIcon
            anchors.centerIn: parent
            property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false
            property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0

            text: muted ? "\ufc5d"
                : volume < 0.3 ? "\ufc5f"
                : volume < 0.7 ? "\ufc5e"
                : "\ufc5c"
            color: muted ? theme.fgDim : theme.fg
            font { family: theme.fontFamily; pixelSize: 14 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                var sink = Pipewire.defaultAudioSink;
                if (sink && sink.audio) {
                    sink.audio.muted = !sink.audio.muted;
                }
            }
        }
    }
}
