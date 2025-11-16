// Vertical_Bar.qml
// File for all the layout and coloring parts of the bar

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules
import qs.modules.components


Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: vertpanel
            required property var modelData
            screen: modelData
            // implicitHeight: 30
            implicitWidth: screen.width * (1.7/100) // 1.7% of the screens width is the vert bar
            color: MainConfig.mainPanel
            // surfaceFormat {opaque:false}
            //color: '#ebe5ac'
            anchors {
                top: true
                //right: true
                left: true
                bottom: true
                
            }
            Rectangle {
                id:panelRect
                anchors.fill: parent
                radius: 0
                color: MainConfig.mainColor
                opacity: MainConfig.mainOpacity
            }
            ColumnLayout {
                id: topcolumn
                anchors.top: parent.top
                //anchors.horizontalCenter: panelRect.horizontalCenter
                opacity: MainConfig.mainTextOpacity
                implicitWidth: vertpanel.width
                implicitHeight: vertpanel.height/3
                //uniformCellSizes: true
                TempWorkspace {
                    // Values supplied to TempWorkspace Widget
                    listorient: ListView.Vertical
                    rectrad: itemwidth * 0.5
                    //itemheight: itemwidth // - 2 // 20 with text
                    //itemwidth: (MainConfig.mainFontSize * 1.1)
                    // Layout vars to align Widget
                    Layout.leftMargin: (vertpanel.width - itemwidth)/2
                    Layout.topMargin: 10
                    Layout.maximumHeight: itemheight*15
                    Layout.alignment: Qt.AlignTop
                }
            }
            ColumnLayout {
                id: middlecolumn
                anchors.centerIn: parent
                spacing: parent.height/250
                opacity: MainConfig.mainTextOpacity
                uniformCellSizes: true
                ClockWidget {
                    // no more time binding
                    // Set the rotation for vertical text
                    /*transform: Rotation {
                        angle: 45 // Rotate by 90 degrees for vertical text
                        axis{x: 0; y: 0; z: 1}
                        origin.x: width 
                        origin.y: height
                    } */
                    // transform: Rotation {origin.x: {column.width/2} origin.y: {column.height/2} angle: 270}
                    timetext: VertTime.time
                    datetext: VertTime.date
                    fontsize: MainConfig.mainFontSize + 1.5
                    // Layout vars
                    Layout.minimumWidth: 16
                    Layout.maximumWidth: 30
                    Layout.alignment: Qt.AlignHCenter 
                }
            }
            ColumnLayout {
                id: bottomcolumn
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    // bottomMargin: parent.height/30
                    // verticalCenter: parent.verticalCenter
                }
                spacing: parent.height/250
                opacity: MainConfig.mainTextOpacity
                uniformCellSizes: true
                VertBatteryWidget{
                    implicitWidth: screen.width/10
                    implicitHeight: screen.height/10
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: vertpanel.height/30
                }
            }
        }
    }
}
