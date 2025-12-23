// Time.qml

import QtQuick
import Quickshell
import Quickshell.Io
// with this line our type becomes a Singleton
pragma Singleton

// your singletons should always have Singleton as the type
Singleton {
    id: timeVert
    readonly property string time: {
        Qt.formatDateTime(clock.date,"hh mm")
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date,"MM dd yy")
    }
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}