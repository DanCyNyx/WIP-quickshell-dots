// Audio.qml: Used to access info from the Pipewire ipc of quickshell for volume access and control
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs.modules
import qs.modules.icons
pragma Singleton
// Code mostly from end-4's illogical impulse and soramane's caelestia-dots github repositories
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

    function setSinkVolume(newVolume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = Math.max (0,Math.min (MainConfig.audio.maxAllowed,newVolume))/100;
        }
    }
    function setSourceVolume(newVolume: real): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = false;
            source.audio.volume = Math.max (0,Math.min (MainConfig.audio.maxAllowed,newVolume))/100;
        }
    }
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
    // My Own Code
    // Finds the easy effects sink by looking through all current link groups
    // Useful for Mixer.qml
    readonly property alias eeRemover:eeRemover
    property PwNode easyEffectsSink
    Variants {
        id: eeRemover
        model: Pipewire.linkGroups.values
        delegate: Item {
            id: eeItem
            required property PwLinkGroup modelData
            property string targetName
            PwObjectTracker {
                objects: [root.sink, modelData?.target, modelData?.source]
            }
            Component.onCompleted: {
                eeItem.targetName = modelData?.target.name
                if (eeItem.modelData?.target.name.includes("easyeffects") && eeItem.modelData?.target.isSink) {
                    root.easyEffectsSink = eeItem.modelData?.target
                }
            }
        }
    }
    // Lists all easy effects Link Groups with stream sources
    property list<PwLinkGroup> eeStreamLinkGroups
    PwNodeLinkTracker {
        id: easyEffectsTracker
        node: easyEffectsSink
    }
    Variants {
        model: easyEffectsTracker.linkGroups
        delegate: Item {
            required property PwLinkGroup modelData
            PwObjectTracker {
                objects: [modelData?.target, modelData?.source]
            }
            Component.onCompleted: {
                if (modelData?.source.isStream && !modelData?.source.name.includes("ee") && !modelData?.source.name.includes("eeasyeffects")) {
                    root.eeStreamLinkGroups.push(modelData)
                }
            }
        }
    }
    // Lists all non-easy effects Link Groups with stream sources
    property list<PwLinkGroup> nonEEStreamLinkGroups
    PwNodeLinkTracker {
        id: speakerTracker
        node: root.sink
    }
    Variants {
        model: speakerTracker.linkGroups
        delegate: Item {
            required property PwLinkGroup modelData
            PwObjectTracker {
                objects: [modelData?.target, modelData?.source]
            }
            Component.onCompleted: {
                if (modelData?.source.isStream && !modelData?.source.name.includes("ee") && !modelData?.source.name.includes("eeasyeffects")) {
                    root.nonEEStreamLinkGroups.push(modelData)
                }
            }
        }
    }
}
