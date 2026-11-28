// WALLPAPERS and other stuff to be drawn in the background.
// Background Rectangle
import QtQuick
import Quickshell
import Quickshell.Wayland
// TODO Background.qml Set it up so that the wallpaper can cycle through a list of images/gifs/videos that can be shuffled or sequentially displayed.
Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: background
        required property var modelData
        screen: modelData
        // either aboveWindows or WlrLayershell.layer. either works
        // aboveWindows: false
        WlrLayershell.layer: WlrLayer.Bottom
        //exclusiveZone: 0
        exclusionMode: ExclusionMode.Auto
        Component.onCompleted: {
            console.log("Component mounted", background.modelData.width, background.modelData.height);
        }
        anchors {
            left: true
            right: true
            top: true
            bottom: true
        }
        AnimatedImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("/home/dani/Pictures/Wallpapers/Monogatari/minimalist.png")
        }
    }
}