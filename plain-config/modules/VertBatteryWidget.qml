// BatteryWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
// pragma Singleton
import qs.modules.components
import qs.modules.icons

// TODO VertBatteryWidget: allow battery info configuration from other files
Item {
    id: root
    // anchors.centerIn: parent
    //spacing: MainConfig.text.fontSize * 2
    implicitHeight: overseer.height // random height, must assign in bar
    implicitWidth: overseer.width // random width, must assign in bar
    Item {
        id: overseer
        implicitHeight: width * 1.1
        implicitWidth: 3 * MainConfig.text.fontSize
        anchors {
            centerIn: root
        }
        // Battery icon creation file
        BatteryVertical {
            id: battIcon
            anchors.fill: overseer
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
        anchors{
            horizontalCenter: root.horizontalCenter
            top: overseer.bottom
        }
    }*/
}

