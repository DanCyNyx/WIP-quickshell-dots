// StyledSlider.qml
import QtQuick
import Quickshell
import QtQuick.Controls
import qs.modules
import qs.modules.icons

Slider {
    id: root
    from: 0
    value: 50
    to: 100
    width: parent.width - 20
    height: handle.height
    // Handles the look of the slider
    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight/2- height/2
        implicitWidth: 200
        implicitHeight: 4
        width: root.availableWidth
        height: implicitHeight
        radius: height/2
        color: '#6b6951'
        //
        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            radius: height/2
            color: MainConfig.colors.main
        }
    }
    handle: Rectangle {
        x: root.visualPosition * (root.availableWidth - width/2)
        //y: root.topPadding + root.availableHeight/2 - height/2
        anchors.verticalCenter: root.background.verticalCenter
        implicitWidth: 13
        implicitHeight: 14
        radius: 3
        color: '#ffffff'
        border.color: '#a4a4a4'
        border.width: 1
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
        }
    }
}