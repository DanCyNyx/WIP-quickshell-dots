import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import qs.modules
pragma Singleton
// File to specify all the icons to use for different parts of the bar
Singleton {
    id: root
    property QtObject volume
    property QtObject performance
    property QtObject brightness
    property QtObject network
    property QtObject mpris
    property string iconFontFamily:"OpenDyslexic Nerd Font Slash" // My version of ODnerd with some customised icons
    // List all the icons for each category here!
    // Most icons were gotten from the nerd-fonts page
    // Volume icons
    volume: QtObject {
        property string headphones: ""
        property string headphonesMuted: "\uefd0" // Custom. Nerd Default: "uf07ce"
        // property string handsFree
        // property string headset
        property string phone: ""
        property string car: ""
        property string microphone: ""
        property string microphoneMuted: ""
        property string bluetooth: ""
        property string bluetoothMuted: "󰂲"
        property QtObject speaker
        property QtObject speakerCen
        speaker: QtObject {
            // I made a custom font for these based off opendyslexic nerd font. It is included in the repo
            // these are not centered in their width
            property string muted: "\ueffb"
            property string low: "\ueffc" 
            property string medium: "\ueffe"
            property string high: "\uefff"
        }
        speakerCen: QtObject {
            property string muted: "\ueee8"
            property string low: "\uf027"
            property string medium: "\ueffd"
            property string high: "\uf028"
        }
    }
    // CPU, GPU and RAM icons
    performance: QtObject {
        property string cpu:"" // online: "64:󰻠,generic:", fastfetch:"", waybar:""
        property string gpu:"󰢮" // online: "󰢮", fastfetch: "󰾲"
        property string ram:"" // online: "", fastfetch: "", waybar: ""
        property string temps: "󰔏"
        property string tempsHigh: "󰸁"
    }
    // Brightness icons
    brightness: QtObject {

    }
    //
    network: QtObject {

    }
    mpris: QtObject {

    }
}