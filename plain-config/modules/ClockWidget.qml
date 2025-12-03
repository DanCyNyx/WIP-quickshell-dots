// ClockWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import qs.modules.components
// pragma Singleton
// example: property alias clocktext: tex
// then i can set clocktext.width in other files
Item {
    // Allows for button, text and font size configuration from other files
    property string timeText: Time.time
    property string dateText: Time.date
    property bool initialBool: true
    property alias clockText: tex
    property alias clockButton: clockButton
    id: root
    RoundButton {
        id: clockButton
        anchors.centerIn: tex
        width: tex.contentWidth + MainConfig.text.fontSize * 0.85
        height: tex.contentHeight + MainConfig.text.fontSize * 0.8
        radius: width/2
        flat: true
        opacity: MainConfig.opacity.button
        onClicked: {
            tex.textIn = initialBool ? Qt.binding(function(){return dateText}) : Qt.binding(function(){return timeText})
            initialBool = !initialBool
        }
    }
    StyledText {
        id: tex
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        textIn: timeText
        fontFamily: MainConfig.text.fontFamily
        fontSize: MainConfig.text.fontSize
    }
}