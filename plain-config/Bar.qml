// Bar.qml
// File for all the layout and coloring parts of the bar

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules
import qs.modules.components

Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            id: panel
            screen: modelData
            implicitHeight: screen.height * (2.32/100) // 2.32% of the screens height is the bars reserved space
            color: Appearance.mainPanel
            // surfaceFormat {opaque:false}
            anchors {
                top: true
                left: true
                right: true
            }
            Rectangle {
                id:barRect
                anchors.fill: parent
                // Should round corners of rectangle but not PanelWindow
                radius: 0
                color: Appearance.mainColor
                opacity: Appearance.mainOpacity
                // color: '#242313'
            }
            RowLayout {
                id: leftRow
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    // rightMargin: parent.width/70
                }
                opacity: Appearance.mainTextOpacity
                implicitHeight: panel.height
                implicitWidth: barRect.width/3
                uniformCellSizes: true
                TempWorkspace {
                    // Layout vars to align widget
                    // Listview item seems to not be centered so this margin fixes that issue
                    Layout.topMargin:(leftRow.height - itemHeight)/2
                    Layout.leftMargin: 10
                    Layout.maximumWidth: itemWidth*15
                    // Values supplied to TempWorkspace Widget
                    // itemwidth: (Appearance.mainFontSize*1.15) // 1.95 with text
                    // itemheight: itemwidth
                    rectRad: itemWidth * 0.5
                }
            }
            RowLayout {
                id: middleRow
                anchors.centerIn: parent
                spacing: parent.width/250
                opacity: Appearance.mainTextOpacity
                implicitWidth: barRect.width/3
                implicitHeight: barRect.height
                uniformCellSizes: true
                ClockWidget {
                    Layout.alignment: Qt.AlignVCenter
                    //timetext: Time.time
                    timeWidth: middleRow.width
                    // font.pointSize: Appearance.mainFontSize+2
                }
            }
            RowLayout {
                id: rightRow
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: parent.width/70
                }
                uniformCellSizes: true
                spacing: parent.width/250
                implicitWidth: barRect.width/3
                implicitHeight: barRect.height
                opacity: Appearance.mainTextOpacity
                BatteryWidget {
                    // spacing: screen.width / 70
                    // text: "; The battery is" + " " + Math.round(Battery.percentage*100) + "%"
                    // font.pointSize: Appearance.mainFontSize+2
                    implicitWidth: screen.width/10
                    implicitHeight: screen.height/10
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}
