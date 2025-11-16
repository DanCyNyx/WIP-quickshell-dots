// Time.qml

import QtQuick
import Quickshell
import Quickshell.Io
// with this line our type becomes a Singleton
pragma Singleton

// Singletons should always have Singleton as the type
Singleton {
    id: timeSing
    readonly property string time: {
        Qt.formatDateTime(clock.date,"hh:mm AP")
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date,"MM-dd-yyyy")
    }
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
