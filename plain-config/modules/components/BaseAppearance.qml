// Folder where all the colors for the plain config are described
// if the folder being used doesn't have designated colors
import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
// TODO change the different parts to qml objects
Singleton {
    // Color of the bar. Default: '#ebe5ac', '#1c1919'
    property string basec: '#ebe5ac'
    
    // Color of the text. Default: '#67323b','#a92037','#ebe5ac'
    property string baseText: '#822b3a'
    // Secondary Color of components. Default: '#912c2c'
    property string baseSecondC: '#417bd9'
    // Color of the background panel. Default: 'transparent'
    property string basePanel: 'transparent'
    // Color of the outlines of specific componenets. Default: '#201f1c'
    property string baseOutline: '#201f1c'
    // Color of inactive workspaces. Default: '#95916d'
    property string baseWorkspace: '#7a7659'
    // Fontsize of text. Default: 10 + 0.25
    property real baseFontSize: (10 + 0.25)
    property string baseFontFamily: "Fleshandblood" // default "Fleshandblood"/"URW Bookman"
    // Opacity/transparency of parts of bar and items in bar
    property real baseOpacity: 0.7
    property real baseTextOpacity: 0.9
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
