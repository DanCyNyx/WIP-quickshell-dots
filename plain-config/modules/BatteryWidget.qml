// BatteryWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
//pragma Singleton
import qs.modules.components
import qs.modules.icons

// TODO BatteryWidget: allow battery info configuration from other files
Item {
    id: root
    // anchors.right: parent
    implicitHeight: 10 // random height, must assign in bar
    implicitWidth: 50 // random width, must assign in bar
    // Displays Text of the battery percentage 
    StyledText {
        id:battText
        textIn: Math.round(Battery.percentage*100) + "%"
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }
    Item {
        anchors {
            left: battText.right
            verticalCenter: parent.verticalCenter
            leftMargin: MainConfig.text.fontSize/5
        }
        implicitHeight: 5.5 * MainConfig.text.fontSize / 2
        implicitWidth: height * 1.2
        // Battery icon creation file
        BatteryHorizontal {
            id: battIcon
            anchors.fill: parent
        }
        // Rectangle to act as charging bar
        Rectangle {
            id: battBar
            implicitHeight: battIcon.height - battIcon.height/1.285
            // Battery.percentage * conversion for icon width to bar max width
            implicitWidth: (battIcon.width/1.8) * Battery.percentage
            anchors {
                left: battIcon.left
                top: battIcon.top
                // Margins to prevent bar from going beyond icon area
                topMargin: battIcon.height / 2.58
                leftMargin: battIcon.width / 5.6 
            }
            color: battIcon.shapefill
            radius: MainConfig.text.fontSize / 9
        }
    }
}