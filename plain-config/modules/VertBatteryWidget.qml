// BatteryWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.UPower
// pragma Singleton
import qs.modules.components
import qs.modules.icons

// TODO VertBatteryWidget: allow battery info configuration from other files
ColumnLayout {
    id: column
    // anchors.centerIn: parent
    spacing: MainConfig.text.fontSize * 2 // find a way to make this be based on screen size
    implicitHeight: 100 // random height, must assign in bar
    implicitWidth: 100 // random width, must assign in bar
    Item {
        id: overseer
        Layout.alignment: Qt.AlignHCenter
        // Battery icon creation file
        BatteryVertical {
            id: battIcon
            implicitWidth: 6 * MainConfig.text.fontSize / 2
            implicitHeight: width * 1.1
            anchors.centerIn: overseer
            
        }
        // Rectangle to act as charging bar
        Rectangle {
            id: battBar
            implicitWidth: battIcon.width - battIcon.width / 1.29
            // Battery.percentage * conversion for icon height to bar max height
            implicitHeight: battIcon.height / 1.81 * Battery.percentage 
            anchors.left: battIcon.left
            anchors.bottom: battIcon.bottom
            // Margins to prevent bar from going beyond icon area
            anchors.bottomMargin: battIcon.height / 5.5
            anchors.leftMargin: battIcon.width / 2.588
            color: battIcon.shapefill
            radius: MainConfig.text.fontSize / 11
        }
    }
    
    // Displays Text of the battery percentage 
    /*
    StyledText {
        id: battText
        text: Math.round(Battery.percentage*100)
        Layout.alignment: Qt.AlignHCenter
    }*/
}

