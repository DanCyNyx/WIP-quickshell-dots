// Vertical_Bar.qml
// File for all the layout and coloring parts of the Vertical Bar
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules
import qs.modules.components
import qs.modules.icons
Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: vertPanel
            required property var modelData
            property real buttonWidth: vertPanel.width - 4
            property bool buttonClicked: false
            screen: modelData
            WlrLayershell.layer: MainConfig.barInfo.layer
            WlrLayershell.namespace: "quickshell: VerticalBar"
            exclusionMode: ExclusionMode.Auto
            // implicitHeight: 30
            implicitWidth: screen.width * (1.7/100) // 1.7% of the screens width is the vert bar
            color: MainConfig.colors.panel
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
                radius: 0 // width/2
                color: MainConfig.colors.main
                opacity: MainConfig.opacity.main
            }
            LazyLoader {
                id: testPopupLoader
                active: buttonClicked
                Popup {
                    id: testPopup
                    property var anchorItem: vertVolume.volumeText
                    readonly property var itemBarLocation: vertPanel.itemPosition(anchorItem)
                    readonly property real itemXPosition: itemBarLocation.x
                    readonly property real itemYPosition: itemBarLocation.y
                    property bool topMarginHigh: itemYPosition + height/2 > vertPanel.height
                    anchors {
                        top: true
                        left: true
                        //bottom: true
                    }
                    //implicitHeight: 100
                    implicitWidth: 56
                    margins {
                        top: topMarginHigh? vertPanel.height - height : itemYPosition + anchorItem?.height/2 - height/2 // Puts it in the middle-left: vertPanel.height/2 - implicitHeight/2
                        left: vertPanel.width * 0.13
                    }
                    // Component.onCompleted: {
                    //     console.log("hi", margins.top)
                    // }
                }
            }
            ColumnLayout {
                id: topColumn
                anchors.top: parent.top
                //anchors.horizontalCenter: panelRect.horizontalCenter
                opacity: MainConfig.opacity.text
                implicitWidth: vertPanel.width
                implicitHeight: vertPanel.height/3
                //uniformCellSizes: true
                TempWorkspace {
                    id: vertWorkspace
                    // Values supplied to TempWorkspace Widget
                    listOrient: ListView.Vertical
                    rectRad: itemWidth * 0.5
                    //itemheight: itemwidth // - 2 // 20 with text
                    //itemwidth: (MainConfig.text.fontSize * 1.1)
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
                opacity: MainConfig.opacity.text
                implicitWidth: vertPanel.width
                implicitHeight: vertPanel.height/3
                uniformCellSizes: true
                ClockWidget {
                    id: vertClock
                    // Tranformation if Time.time is used instead of VertTime.time
                    // /transform: Rotation {origin.x: {middleColumn.width/2} origin.y: {middleColumn.height/2} angle: 270}
                    timeText: VertTime.time
                    dateText: VertTime.date
                    clockText.width: panelRect.width - 6
                    clockText.fontSize: MainConfig.text.fontSize + 1.5
                    clockButton.height: clockText.height + MainConfig.text.fontSize *1.5
                    clockButton.width: vertPanel.buttonWidth
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
                    //top: middleColumn.bottom
                    // bottomMargin: parent.height/30
                    // verticalCenter: parent.verticalCenter
                }
                spacing: MainConfig.text.fontSize * 0.6
                opacity: MainConfig.opacity.text
                implicitWidth: vertPanel.width
                implicitHeight: vertPanel.height/3
                //uniformCellSizes: true
                VolumeWidget {
                    id: vertVolume
                    Layout.preferredWidth: Math.max(micText.contentWidth,volumeText.contentWidth)
                    Layout.alignment: Qt.AlignHCenter || Qt.AlignTop
                    implicitWidth: Math.max(micText.contentWidth,volumeText.contentWidth)
                    implicitHeight: volumeText.contentHeight //+ micText.contentHeight
                    sourceAudio: null
                    volumeButton.width: buttonWidth
                    volumeButton.height: volumeButton.width //height + 4
                    volumeButton.onClicked: {
                        buttonClicked = !buttonClicked
                    }
                    // Adds a microphone icon once micText.contentHeight and mictext.anchors are uncommented
                    // micText.anchors {
                    //     left: volumeText.left
                    //     top: volumeText.bottom
                    //     leftMargin: 0
                    //     horizontalCenter: vertVolume.horizontalCenter
                    // }
                }
                VertBatteryWidget {
                    id: vertBattery
                    Layout.alignment: Qt.AlignHCenter || Qt.AlignTop
                    Layout.bottomMargin: vertPanel.height/40
                    Layout.rightMargin: 1 // vertPanel.width / 100
                }
            }
        }
    }
}
