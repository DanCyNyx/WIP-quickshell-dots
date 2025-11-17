// Vertical_Bar.qml
// File for all the layout and coloring parts of the bar

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules
import qs.modules.components
import qs.modules.icons


Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: vertPanel
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
                id: topColumn
                anchors.top: parent.top
                //anchors.horizontalCenter: panelRect.horizontalCenter
                opacity: MainConfig.mainTextOpacity
                implicitWidth: vertPanel.width
                implicitHeight: vertPanel.height/3
                //uniformCellSizes: true
                TempWorkspace {
                    // Values supplied to TempWorkspace Widget
                    listOrient: ListView.Vertical
                    rectRad: itemWidth * 0.5
                    //itemheight: itemwidth // - 2 // 20 with text
                    //itemwidth: (MainConfig.mainFontSize * 1.1)
                    // Layout vars to align Widget
                    // Listview items seem to not be centered so this margin fixes that issue
                    Layout.leftMargin: (vertPanel.width - itemWidth)/2
                    Layout.topMargin: 10
                    Layout.maximumHeight: itemHeight * 15
                    Layout.alignment: Qt.AlignTop
                }
            }
            ColumnLayout {
                id: middleColumn
                anchors.centerIn: parent
                spacing: parent.height/250
                opacity: MainConfig.mainTextOpacity
                uniformCellSizes: true
                ClockWidget {
                    // Tranformation if time.time is used instead of VertTime.time
                    // Set the rotation for vertical text
                    // transform: Rotation {origin.x: {column.width/2} origin.y: {column.height/2} angle: 270}
                    timeText: VertTime.time
                    dateText: VertTime.date
                    fontSize: MainConfig.mainFontSize + 1.5
                    // fontFamily:FontIcons.iconFontFamily
                    // Layout vars
                    Layout.minimumWidth: 16
                    Layout.maximumWidth: 30
                    Layout.alignment: Qt.AlignHCenter 
                }
            }
            ColumnLayout {
                id: bottomColumn
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
                    Layout.bottomMargin: vertPanel.height/30
                }
            }
        }
    }
}
