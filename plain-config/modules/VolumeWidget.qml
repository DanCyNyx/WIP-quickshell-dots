import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.modules.components
import qs.modules.icons
// TODO VolumeWidget: add a volume popup
Item {
    id: root
    property alias volumeText: volumeText
    property alias micText: micText
    property alias volumeButton: volumeButton
    //property alias volumePopup: volumePopup
    property var sinkAudio: Audio.sink?.audio
    property var sourceAudio: Audio.source?.audio
    property string sinkType: "Speaker"
    property var sinkName: Audio.sink?.name
    implicitWidth: volumeText.contentWidth + micText.contentWidth + micText.anchors.leftMargin //+ 10
    implicitHeight: Math.max(micText.contentHeight, volumeText.contentHeight)
    // Target the current default audio sink and source in order to get volume info
    PwObjectTracker {
        objects: [Audio.sink, Audio.source]
    }
    // Function to determine what type of sink the pipewire default is 
    // currently only have support for bluetoothctl/bluez bluetooth speakers/headphones
    function iconAssign() {
        if (sinkName.includes("bluez_output")) {sinkType = "Bluetooth"}
        else {sinkType = "Speaker"}
    }
    // Function and connections for speaker audio
    function volumeCheck() {
        if (sinkType == "Speaker") {
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
        else if (sinkType == "Bluetooth") {
            if (sinkAudio?.volume !== 0 && !Audio.sinkMuted) {
                volumeText.textIn = FontIcons.volume.bluetooth
            }
            else if (sinkAudio?.volume == 0 || Audio.sinkMuted) {
                volumeText.textIn = FontIcons.volume.bluetoothMuted
            }
        }
    }
    Connections {
        target: sinkAudio ?? null
        function onVolumeChanged() {
            iconAssign()
            volumeCheck()
        }
        function onMutedChanged() {
            iconAssign()
            volumeCheck()
        }
    }
    // Functions and connections for microphone audio
    function micCheck() {
        if (sourceAudio?.volume == 0 || Audio.sourceMuted) {
            micText.textIn = FontIcons.volume.microphoneMuted;
        } else if (sourceAudio?.volume > 0 && !Audio.sourceMuted ) {micText.textIn = FontIcons.volume.microphone}
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
        iconAssign()
        volumeCheck()
        micCheck()
    }
    onSinkNameChanged: {
        iconAssign()
        volumeCheck()
        console.log("",sinkName)
    }
    RoundButton {
        id: volumeButton
        anchors.centerIn: parent
        width: parent.width + 10
        height: parent.height - 2
        radius: width/2
        flat: true
        opacity: MainConfig.opacity.button
    }
    // The actual icons
    StyledText {
        id: volumeText
        fontFamily: FontIcons.iconFontFamily
        textIn: "Audio N/A"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    StyledText {
        id: micText
        fontFamily: FontIcons.iconFontFamily
        textIn: ""//"Mic N/A"
        anchors.left: volumeText.right
        anchors.leftMargin: MainConfig.text.fontSize*0.7
        anchors.verticalCenter: parent.verticalCenter
    }
}