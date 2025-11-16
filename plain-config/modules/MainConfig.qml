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
    property color mainColor: BaseConfig.basec
    property color secondaryColor: BaseConfig.baseSecondC
    property color mainText: BaseConfig.baseText
    property color mainPanel: BaseConfig.basePanel
    property color mainOutline: BaseConfig.baseOutline
    property color inactiveWorkspace: BaseConfig.baseWorkspace
    
    ///////////
    // Fonts //
    ///////////
    property real mainFontSize: BaseConfig.baseFontSize
    property string mainFontFamily: BaseConfig.baseFontFamily
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string filename: 'BaseConfig'
    /////////////
    // Opacity //
    /////////////
    property real mainOpacity: BaseConfig.baseOpacity
    property real mainTextOpacity: BaseConfig.baseTextOpacity
    
    function playSystemSound(soundName) {
        BaseConfig.playSystemSound(soundName)
    }
}