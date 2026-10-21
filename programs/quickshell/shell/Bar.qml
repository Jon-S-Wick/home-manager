import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: bar
    spacing: 6

    property var theme

    Workspaces {
        Layout.fillWidth: false
        theme: bar.theme
    }

    Item { Layout.fillWidth: true }

    Clock {
        Layout.fillWidth: false
        theme: bar.theme
    }

    Item { Layout.fillWidth: true }

    AudioWidget {
        Layout.fillWidth: false
        theme: bar.theme
    }

    BluetoothWidget {
        Layout.fillWidth: false
        theme: bar.theme
    }

    WifiWidget {
        Layout.fillWidth: false
        theme: bar.theme
    }

    BatteryWidget {
        Layout.fillWidth: false
        theme: bar.theme
    }

    TrayWidget {
        Layout.fillWidth: false
        theme: bar.theme
    }
}
