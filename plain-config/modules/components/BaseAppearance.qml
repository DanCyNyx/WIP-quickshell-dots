// Folder where all the colors for the plain config are described
// if the folder being used doesn't have designated colors
import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    // Color of the bar. Default: '#ebe5ac', '#1c1919'
    property string basec: '#ebe5ac'
    
    // Color of the text. Default: '#67323b','#a92037','#ebe5ac'
    property string basetext: '#822b3a'

    // Secondary Color of components. Default: '#912c2c'
    property string basesecondc: '#417bd9'

    // Color of the background panel. Default: 'transparent'
    property string basepanel: 'transparent'

    // Color of the outlines of specific componenets. Default: '#201f1c'
    property string baseoutline: '#201f1c'

    // Color of inactive workspaces. Default: '#95916d'
    property string baseworkspace: '#7a7659'

    // Fontsize of text. Default: 10 + 0.25
    property real basefontsize: (10 + 0.25)
    property string basefontfamily: "Fleshandblood" // default "Fleshandblood"/"URW Bookman"

    // Opacity/transparency of parts of bar and items in bar
    property real baseopacity: 0.7
    property real baseTextopacity: 0.9
    /////////////////
    // Audio Stuff //
    /////////////////
    property string audio: "freedesktop"

    function playSystemSound(soundName) {
        const ogaPath = `/usr/share/sounds/${audio}/stereo/${soundName}.oga`;
        const oggPath = `/usr/share/sounds/${audio}/stereo/${soundName}.ogg`;

        // Try playing .oga first
        let command = [
            "ffplay",
            "-nodisp",
            "-autoexit",
            ogaPath
        ];
        Quickshell.execDetached(command);

        // Also try playing .ogg (ffplay will just fail silently if file doesn't exist)
        command = [
            "ffplay",
            "-nodisp",
            "-autoexit",
            oggPath
        ];
        Quickshell.execDetached(command);
    }
}

/* Text {
    property string myText: "red"
    id: base
    text: myText
}
*/
