// Volume.qml: Used to acces info from the Pipewire ipc of quickshell for volume access and control
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.modules
import qs.modules.icons
pragma Singleton
// code mostly from end-4's illogical impulse dotfiles
Singleton {
    id: root
    property string previousSinkName: ""
    property string previousSourceName: ""
    readonly property var nodes: Pipewire.nodes.values.reduce((acc,node)=> {
        if (!node.isStream) {
            if (node.isSink)
                acc.sinks.push(node);
            else if (node.audio)
                acc.sources.push(node);
        }
        return acc;
    },{
        sources: [],
        sinks: []
    })
    readonly property list<PwNode> sinks: nodes.sinks
    readonly property list<PwNode> sources: nodes.sources
    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    property bool sinkMuted: !!sink?.audio?.muted
    property bool sourceMuted: !!source?.audio?.muted
    readonly property real hardMaxValue: 2.00 // prevents volume control from accidentally going beyond 200%
    signal sinkProtectionTriggered(string reason);
    PwObjectTracker {
        objects: [...root.sinks, ...root.sources, sink, source]
    }
    Connections {
        id: sinkConnect
        target: sink?.audio ?? null
        property bool lastReady: false
        property real lastVolume: 0
        function onVolumeChanged() {
            if (!MainConfig.audio.protectionEnabled) return;
            const newVolume = sink.audio.volume;
            /// when resuming from suspend, we should not write volume to avoid pipewire volume reset issues
            if (isNaN(newVolume) || newVolume === undefined || newVolume === null) {
                lastReady = false;
                lastVolume = 0;
                return;
            }
            if (!lastReady) {
                lastVolume = newVolume;
                lastReady = true;
                return;
            }
            const maxAllowedIncrease = MainConfig.audio.maxAllowedIncrease / 100;
            const maxAllowed = MainConfig.audio.maxAllowed / 100;
            if (newVolume - lastVolume > maxAllowedIncrease) {
                sink.audio.volume = lastVolume;
                root.sinkProtectionTriggered("Illegal increment");
            } else if (newVolume > maxAllowed || newVolume > root.hardMaxValue) {
                root.sinkProtectionTriggered("Exceeded max allowed volume");
                sink.audio.volume = Math.min(lastVolume,maxAllowed);
            }
            lastVolume = sink.audio.volume;
        }
    }
}
