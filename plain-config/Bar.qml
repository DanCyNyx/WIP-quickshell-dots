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
            WlrLayershell.layer: WlrLayer.Top
            exclusionMode: ExclusionMode.Auto
            implicitHeight: screen.height * (2.32/100) // 2.32% of the screens height is the bars reserved space
            color: MainConfig.mainPanel
            //surfaceFormat {opaque:false}
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
                color: MainConfig.mainColor
                opacity: MainConfig.mainOpacity
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
                opacity: MainConfig.mainTextOpacity
                implicitHeight: panel.height
                //implicitWidth: barRect.width/3
                uniformCellSizes: true
                TempWorkspace {
                    // Layout vars to align widget
                    // Listview item seems to not be centered so this margin fixes that issue
                    Layout.topMargin:(leftRow.height - itemHeight)/2
                    Layout.leftMargin: 10
                    Layout.maximumWidth: itemWidth*15
                    // Values supplied to TempWorkspace Widget
                    // itemwidth: (MainConfig.mainFontSize*1.15) // 1.95 with text
                    // itemheight: itemwidth
                    rectRad: itemWidth * 0.5
                }
            }
            RowLayout {
                id: middleRow
                anchors.centerIn: parent
                spacing: MainConfig.mainFontSize
                opacity: MainConfig.mainTextOpacity
                //implicitWidth: barRect.width/3
                implicitHeight: barRect.height
                //uniformCellSizes: true
                ClockWidget {
                    Layout.alignment: Qt.AlignHCenter || Qt.AlignVCenter
                    //timetext: Time.time
                    Layout.preferredWidth: clockText.contentWidth
                    //clockText.width: MainConfig.mainFontSize * 8
                    // font.pointSize: MainConfig.mainFontSize+2
                }
            }
            RowLayout {
                id: rightRow
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: barRect.right
                    rightMargin: MainConfig.mainFontSize * 3
                }
                //uniformCellSizes: true
                //implicitWidth: panel.width/3 - anchors.rightMargin
                implicitHeight: panel.height
                spacing: MainConfig.mainFontSize*1.6
                opacity: MainConfig.mainTextOpacity
                VolumeWidget {
                    id: barVolume
                    //Layout.preferredWidth: implicitWidth*1.68
                    Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                    }
                BatteryWidget {
                    // text: "; The battery is" + " " + Math.round(Battery.percentage*100) + "%"
                    // font.pointSize: MainConfig.mainFontSize+2
                    // Layout.preferredWidth: rightRow.width / 12
                    implicitHeight: rightRow.height
                    // Layout.maximumWidth: rightRow.width / 2
                    Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                }
            }
        }
    }
}
