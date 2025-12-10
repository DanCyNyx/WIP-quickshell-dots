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
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            property real buttonHeight: panel.height - 2
            id: panel
            screen: modelData
            WlrLayershell.layer: MainConfig.barInfo.layer
            WlrLayershell.namespace: "quickshell: Bar"
            exclusionMode: ExclusionMode.Auto
            implicitHeight: screen.height * (2.32/100) // 2.32% of the screens height is the bars reserved space
            color: MainConfig.colors.panel
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
                color: MainConfig.colors.main
                opacity:MainConfig.opacity.main
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
                opacity: MainConfig.opacity.text
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
                    // itemwidth: (MainConfig.text.fontSize*1.15) // 1.95 with text
                    // itemheight: itemwidth
                    rectRad: itemWidth * 0.5
                }
            }
            RowLayout {
                id: middleRow
                anchors.centerIn: parent
                spacing: MainConfig.text.fontSize
                opacity: MainConfig.opacity.text
                //implicitWidth: barRect.width/3
                implicitHeight: barRect.height
                //uniformCellSizes: true
                ClockWidget {
                    Layout.alignment: Qt.AlignHCenter || Qt.AlignVCenter
                    //timetext: Time.time
                    Layout.preferredWidth: clockText.contentWidth
                    clockButton.height: buttonHeight
                    clockButton.width: clockText.width + MainConfig.text.fontSize *1.5
                    //clockText.width: MainConfig.text.fontSize * 8
                    // font.pointSize: MainConfig.text.fontSize+2
                }
            }
            RowLayout {
                id: rightRow
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: barRect.right
                    rightMargin: MainConfig.text.fontSize * 3
                }
                //uniformCellSizes: true
                //implicitWidth: panel.width/3 - anchors.rightMargin
                implicitHeight: panel.height
                spacing: MainConfig.text.fontSize*1.7
                opacity: MainConfig.opacity.text
                VolumeWidget {
                    id: barVolume
                    //Layout.preferredWidth: implicitWidth*1.68
                    Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                    volumeButton.height: buttonHeight
                    }
                BatteryWidget {
                    // text: "; The battery is" + " " + Math.round(Battery.percentage*100) + "%"
                    // font.pointSize: MainConfig.text.fontSize+2
                    // Layout.preferredWidth: rightRow.width / 12
                    implicitHeight: rightRow.height
                    // Layout.maximumWidth: rightRow.width / 2
                    Layout.alignment: Qt.AlignRight || Qt.AlignVCenter
                }
            }
        }
    }
}
