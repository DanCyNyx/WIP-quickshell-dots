// Imports configuration choices from a file and saves them as a qml var
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules
Singleton {
    id: root
    //////////////////////
    // Folder for theme //
    //////////////////////
    property string wallpaper: MainConfig.wallpaper
    property bool useThemeConfig: MainConfig.useThemeConfig
    property string user: MainConfig.user
    property string configFilepath: MainConfig.configFilepath // Default path for the config file
    property string theme: MainConfig.theme
    // Chooses the config file based on the theme or 
    function configChoose(): string {
        // Assume the user's wallpaper is at pictures/wallpaper 
        // and take the folder name of the wallpaper
        if (wallpaper.length!=0 & theme!="None") {
            var themeConfigPath=Qt.resolvedUrl(`${MainConfig.configDir}/quickshell/plain-config/modules/Themes/${theme}/Config.json`)
        } else if (wallpaper.length==0 | theme==="None") {MainConfig.useThemeConfig=false}
        var newpath= useThemeConfig? themeConfigPath:Qt.resolvedUrl(`${configFilepath}`)
        if (newpath!=configViewer.path) {
            configViewer.path = "" 
            configViewer.path=newpath;
        }
        return newpath
    }
    // Reads the config file and saves it as an object
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
    readonly property string configPath: configViewer.path.replace("file://","")
}