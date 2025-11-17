// Folder where all the configuration options for the plain config are described
// if the folder being used doesn't have designated config
import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
Singleton {
    property QtObject colors
    property QtObject audio
    property QtObject text
    property QtObject opacity
    // All colors
    colors: QtObject {
        // Primary colors (color of bar). Default: '#ebe5ac', '#1c1919'
        property string primary: '#ebe5ac'
        // Secondary Color of components. Default: '#912c2c'
        property string secondary: '#417bd9'
        // Color of the text. Default: '#67323b','#a92037','#ebe5ac'
        property string textcolor: '#822b3a'
        // Color of the background panel. Default: 'transparent'
        property string panel: 'transparent'
        // Color of the outlines of specific componenets. Default: '#201f1c'
        property string outline: '#201f1c'
        // Color of inactive workspaces. Default: '#95916d'
        property string workspace: '#7a7659'
    }
    // Text options configuration
    text: QtObject {
        // Fontsize of text. Default: 10 + 0.25
        property real fontSize: (10 + 0.25)
        property string fontFamily: "fleshandblood" // default "Fleshandblood"/"URW Bookman"
    }
    // Opacity options
    opacity: QtObject {
        // Opacity/transparency of parts of bar and items in bar
        property real mainOpacity: 0.7
        property real textOpacity: 0.9
    }
    // Audio configuration
    audio: QtObject {
        /////////////////
        // Audio Stuff //
        /////////////////
        property string audiofolder: "freedesktop"
        function playSystemSound(soundName) {
            const ogaPath = `/usr/share/sounds/${audiofolder}/stereo/${soundName}.oga`;
            const oggPath = `/usr/share/sounds/${audiofolder}/stereo/${soundName}.ogg`;
            /* Add this to play mp3 files
            const mp3Path = `/home/dani/Downloads/${soundName}.mp3`;
            // Try playing .mp3 
            let command = [
                "ffplay",
                "-nodisp",
                "-autoexit",
                mp3Path
            ];
            Quickshell.execDetached(command);*/
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
}
