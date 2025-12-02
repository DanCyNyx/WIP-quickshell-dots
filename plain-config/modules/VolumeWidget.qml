import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.modules.components
import qs.modules.icons

Item {
    id: root
    property alias volumeText: volumeText
    //property alias volumePopup: volumePopup
    property var sinkAudio: Audio.sink?.audio
    property var sourceAudio: Audio.source?.audio
    implicitWidth: volumeText.contentWidth + micText.contentWidth + 10
    // Target the current default audio sink and source in order to get volume info
    PwObjectTracker {
        objects: [Audio.sink, Audio.source]
    }
    // Function and connections for speaker audio
    function volumeCheck() {
        if (sinkAudio?.volume <= 30/100 && sinkAudio?.volume !== 0 && !Audio.sinkMuted) {
            volumeText.textIn = FontIcons.volume.speaker.low;
        } else if (sinkAudio?.volume >= 30/100 && sinkAudio?.volume <= 60/100 && !Audio.sinkMuted) {
            volumeText.textIn = FontIcons.volume.speaker.medium;
        } else if (sinkAudio?.volume >= 60/100 && !Audio.sinkMuted) {
            volumeText.textIn = FontIcons.volume.speaker.high;
        } else if (sinkAudio?.volume == 0 || Audio.sinkMuted) {
            volumeText.textIn = FontIcons.volume.speaker.muted;
        }
    }
    Connections {
        target: sinkAudio ?? null
        function onVolumeChanged() {
            volumeCheck()
        }
        function onMutedChanged() {
            volumeCheck()
        }
    }
    // Functions and connections for microphone audio
    function micCheck() {
        if (sourceAudio?.volume == 0 || Audio.sourceMuted) {
            micText.textIn = FontIcons.volume.microphoneMuted;
        } else if (sourceAudio?.volume !== 0 && !Audio.sourceMuted ) {micText.textIn = FontIcons.volume.microphone}
    }
    Connections {
        target: sourceAudio ?? null
        function onVolumeChanged() {
            micCheck()
        }
        function onMutedChanged() {
            micCheck()
        }
    }
    // Reload the icons on startup and whenever widget is run
    // Helps make sure icons are correct on startup
    Component.onCompleted: {
        volumeCheck ()
        micCheck()
    }
    // The actual icons
    StyledText {
        id: volumeText
        styledFontFamily: FontIcons.iconFontFamily
        textIn: "Audio out N/A"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    StyledText {
        id: micText
        styledFontFamily: FontIcons.iconFontFamily
        textIn: "Mic N/A"
        anchors.left: volumeText.right
        anchors.leftMargin: MainConfig.mainFontSize*0.7
        anchors.verticalCenter: parent.verticalCenter
    }
    // PopupWindow {
    //     id: volumePopup
    //     anchor.item: root
    //     visible: true
    //     implicitWidth: 400
    //     implicitHeight: 50
    //     color: "transparent"
    //     Rectangle {
    //         anchors.fill: parent
    //         radius: width/10
    //         color: MainConfig.mainColor
    //         opacity: MainConfig.mainOpacity
    //     }
    // }
}