// Imports color variables from componenets or specific wallpaper folders
import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.components
pragma Singleton

Singleton {
    // Appearance of the bar based on specific appearance file

    ////////////
    // Colors //
    ////////////
    property color maincolor: BaseAppearance.basec
    property color secondarycolor: BaseAppearance.basesecondc
    property color maintext: BaseAppearance.basetext
    property color mainpanel: BaseAppearance.basepanel
    property color mainoutline: BaseAppearance.baseoutline
    property color inactiveworkspace: BaseAppearance.baseworkspace
    

    ///////////
    // Fonts //
    ///////////
    property real mainfontsize: BaseAppearance.basefontsize
    property string mainfontfamily: BaseAppearance.basefontfamily
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string filename: 'BaseAppearance'
    /////////////
    // Opacity //
    /////////////
    property real mainopacity: BaseAppearance.baseopacity
    property real mainTextOpacity: BaseAppearance.baseTextopacity
    
    function playSystemSound(soundName) {
        BaseAppearance.playSystemSound(soundName)
    }
}


/* Text {
    id: mainc
    text: maincolor
}
*/
