// Imports configuration choices from components or specific wallpaper folders and applies them to bars
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.components
pragma Singleton
/* TODO MainConfig: make this file able to change what colours and configuration it has
* based on values supplied by a qml file based on the folder the wallpaper is from
*/
Singleton {
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string filename: 'BaseConfig'
    // Qt objects containing all the file configuration options
    property QtObject colors
    property QtObject text
    property QtObject opacity
    property QtObject audio
    property QtObject barInfo
    property QtObject battery
    
    // MainConfig of the bars based on specific config file
    ///////////////////////////////
    // Quickshell Widget windows //
    ///////////////////////////////
    barInfo: QtObject {
        property var layer: WlrLayer.Top
    }
    /////////////
    // Battery //
    /////////////
    battery: QtObject {
        property bool isFunctional: false
        property bool automaticSuspend: false
    }
    ////////////
    // Colors //
    ////////////
    colors: QtObject {
        property color main: BaseConfig.colors.primary
        property color secondary: BaseConfig.colors.secondary
        property color text: BaseConfig.colors.textcolor
        property color panel: BaseConfig.colors.panel
        property color outline: BaseConfig.colors.outline
        property color inactiveWorkspace: BaseConfig.colors.workspace
    }
    //////////
    // Text //
    //////////
    text: QtObject {
        property real fontSize: BaseConfig.text.fontSize
        property string fontFamily: BaseConfig.text.fontFamily
    }
    /////////////
    // Opacity //
    /////////////
    opacity: QtObject {
        property real main: BaseConfig.opacity.mainOpacity
        property real text: BaseConfig.opacity.textOpacity
        property real button: BaseConfig.opacity.buttonOpacity
    }
    ///////////
    // Audio //
    ///////////
    audio: QtObject {
        property bool protectionEnabled: true
        property real maxAllowedIncrease: 10
        property real maxAllowed: 100
        function playSystemSound(soundName) {
            BaseConfig.audio.playSystemSound(soundName)
        }
    }
}