// Imports configuration choices from components or specific wallpaper folders and applies them to bars
import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.components
pragma Singleton
/* TODO MainConfig: make this file able to change what colours and configuration it has
* based on values supplied by a qml file based on the folder the wallpaper is from
*/
// TODO change the singleton values to qml objects
Singleton {
    // MainConfig of the bar based on specific config file
    ////////////
    // Colors //
    ////////////
    property color mainColor: BaseConfig.colors.primary
    property color secondaryColor: BaseConfig.colors.secondary
    property color mainText: BaseConfig.colors.textcolor
    property color mainPanel: BaseConfig.colors.panel
    property color mainOutline: BaseConfig.colors.outline
    property color inactiveWorkspace: BaseConfig.colors.workspace
    ///////////
    // Fonts //
    ///////////
    property real mainFontSize: BaseConfig.text.fontSize
    property string mainFontFamily: BaseConfig.text.fontFamily
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string filename: 'BaseConfig'
    /////////////
    // Opacity //
    /////////////
    property real mainOpacity: BaseConfig.opacity.mainOpacity
    property real mainTextOpacity: BaseConfig.opacity.textOpacity
    ///////////
    // Audio //
    ///////////
    function playSystemSound(soundName) {
        BaseConfig.audio.playSystemSound(soundName)
    }
}