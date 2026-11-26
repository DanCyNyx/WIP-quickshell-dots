// Imports configuration choices from components or specific wallpaper folders and applies them to bars
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.components
/* TODO MainConfig: add the option to switch between manually setting the 
filename/path for config and basing the configs location on wallpaper folder*/
Singleton {
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string wallpaper: ""
    property string filename: "BaseConfig"
    // Reads the config file and saves it as an object
    function configChoose(): void {
        var newpath=Qt.resolvedUrl(`./components/${filename}.json`)
        if (newpath!=configViewer.path) {
            configViewer.path = "" 
            configViewer.path=newpath;
        }
    }
    FileView {
            id: configViewer
            path: ""
            // Forces the file to be loaded by the time we call JSON.parse().
            blockLoading: true
            preload: false
            watchChanges:true
            onFileChanged: this.reload()
            Component.onCompleted: {
                configChoose()
                }
        }
    readonly property var config: JSON.parse(configViewer.text())
    // Qt objects containing all the file configuration options
    property QtObject colors
    property QtObject text
    property QtObject opacity
    property QtObject audio
    property QtObject barInfo
    property QtObject battery
    property QtObject shell
    
    // MainConfig of the bars based on specific config file
    ///////////////////////////////
    // Quickshell Widget windows //
    ///////////////////////////////
    barInfo: QtObject {
        property var layer: WlrLayer.Top
    }
    ///////////
    // Shell //
    ///////////
    shell: QtObject{
        property bool vertBarActive: true
        property bool horiBarActive: true
    }
    /////////////
    // Battery //
    /////////////
    battery: QtObject {
        property bool isFunctional: true
        property bool automaticSuspend: false
    }
    ////////////
    // Colors //
    ////////////
    colors: QtObject {
        property color main: config.colors.primary
        property color secondary: config.colors.secondary
        property color text: config.colors.textcolor
        property color panel: config.colors.panel
        property color outline: config.colors.outline
        property color inactiveWorkspace: config.colors.workspace
    }
    //////////
    // Text //
    //////////
    text: QtObject {
        property real fontSize: config.text.fontSize
        property string fontFamily: config.text.fontFamily
        property string secondaryFontFamily: config.text.secondaryFontFamily
    }
    /////////////
    // Opacity //
    /////////////
    opacity: QtObject {
        property real main: config.opacity.main
        property real text: config.opacity.text
        property real button: config.opacity.button
    }
    ///////////
    // Audio //
    ///////////
    audio: QtObject {
        property bool protectionEnabled: false
        property real maxAllowedIncrease: 30
        property real maxAllowed: 100
        property string folder: config.audio.folder
        function playSystemSound(soundName) {
            const ogaPath = `/usr/share/sounds/${audio.folder}/stereo/${soundName}.oga`;
            const oggPath = `/usr/share/sounds/${audio.folder}/stereo/${soundName}.ogg`;
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
