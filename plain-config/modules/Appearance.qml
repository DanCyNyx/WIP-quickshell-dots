// Imports color variables from componenets or specific wallpaper folders
import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.components
pragma Singleton
/* TODO Appearance: make this file able to change what colours and configuration it has
* based on values supplied by a qml file based on the folder the wallpaper is from
*/
// TODO change the singleton values to qml objects
Singleton {
    // Appearance of the bar based on specific appearance file
    ////////////
    // Colors //
    ////////////
    property color mainColor: BaseAppearance.basec
    property color secondaryColor: BaseAppearance.baseSecondC
    property color mainText: BaseAppearance.baseText
    property color mainPanel: BaseAppearance.basePanel
    property color mainOutline: BaseAppearance.baseOutline
    property color inactiveWorkspace: BaseAppearance.baseWorkspace
    
    ///////////
    // Fonts //
    ///////////
    property real mainFontSize: BaseAppearance.baseFontSize
    property string mainFontFamily: BaseAppearance.baseFontFamily
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string filename: 'BaseAppearance'
    /////////////
    // Opacity //
    /////////////
    property real mainOpacity: BaseAppearance.baseOpacity
    property real mainTextOpacity: BaseAppearance.baseTextOpacity
    
    function playSystemSound(soundName) {
        BaseAppearance.playSystemSound(soundName)
    }
}