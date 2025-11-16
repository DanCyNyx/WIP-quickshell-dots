// BatteryWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
//pragma Singleton
import qs.modules.components
import qs.modules
import qs.modules.svgIcons

// TODO BatteryWidget: allow battery info configuration from other files
RowLayout {
    id: row
    // anchors.right: parent
    spacing: MainConfig.mainFontSize * 2 // find a way to make this be based on screen size
    implicitHeight: 100 // random height, must assign in bar
    implicitWidth: 100 // random width, must assign in bar
    // Displays Text of the battery percentage 
    Text {
        id:battTex
        text: Math.round(Battery.percentage*100) + "%"
        font.family: MainConfig.mainFontFamily
        font.pointSize: MainConfig.mainFontSize
        Layout.alignment: Qt.AlignVCenter
        wrapMode: Text.Wrap
        color: MainConfig.mainText
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
    }
    Item {
        Layout.alignment: Qt.AlignVCenter
        // Battery icon creation file
        BatteryHorizontal {
            id: battIcon
            implicitHeight: 5.5 * MainConfig.mainFontSize / 2
            implicitWidth: height * 1.2
            anchors.centerIn: parent
            
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
            radius: MainConfig.mainFontSize / 9
        }
    }
}