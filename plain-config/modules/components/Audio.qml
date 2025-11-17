// Volume.qml: Used to acces info from the Pipewire ipc of quickshell for volume access and control
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.modules
import qs.modules.icons
pragma Singleton

Singleton {
    id: root
    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    
}
