// Base Popup Window to use for every popup window made for every other module
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import qs.modules
// TODO Popup: make a popup using either PanelWindow or PopupWindow or maybe a FloatingWindow?
// Make a panel window with a configurable size that is placed in a lazyloader
// that panel window should be able to anchor itself to whatever spot the popup is supposed to show up in or to the top of the screen and have a specific width
PanelWindow {
    property alias background: backgroundRect
    anchors {
        top: false
        bottom: false
        left: false
        right: false
    }
    margins {
        top: 0
        bottom: 0
        left: 0
        right: 0
    }
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell: Popup"
    exclusionMode: ExclusionMode.Normal
    implicitWidth: 100
    implicitHeight: 10 // + popupText.contentHeight
    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: MainConfig.colors.text
        opacity: MainConfig.opacity.text
        radius: width/2 - width * 0.33 //0
    }
    // RoundButton {
    //     anchors.centerIn: popupText
    //     width: popupText.contentWidth + 6
    //     height: popupText.contentHeight + MainConfig.text.fontSize * 0.3
    //     radius: width/2
    //     flat: true
    //     opacity: MainConfig.opacity.button
    // }
    // StyledText {
    //     id: popupText
    //     textIn: Math.round(Audio.sink.audio.volume*100) + "%"
    //     anchors.centerIn: parent
    //     verticalAlignment: Text.AlignVCenter
    //     horizontalAlignment: Text.AlignHCenter
    //     width: parent.width
    //     color: "white"
    // }
    color: MainConfig.colors.panel
}