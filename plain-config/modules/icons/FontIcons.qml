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
    property string iconFontFamily:"OpenDyslexic Nerd Font" // "JetBrainsMono Nerd Font Mono"
    // List all the icons for each category here!
    // All icons were gotten from the nerd-fonts page
    // Volume icons
    volume: QtObject {
        property string headphones: ""
        property string headphonesMuted: "󰟎"
        // property string handsFree
        // property string headset
        property string phone: ""
        property string car: ""
        property string microphone: ""
        property string microphoneMuted: ""
        property string bluetooth: ""
        property string bluetoothMuted: "󰂲"
        property QtObject speaker
        speaker: QtObject {
            property string low: ""
            property string medium: ""
            property string high: ""
            property string muted: ""
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