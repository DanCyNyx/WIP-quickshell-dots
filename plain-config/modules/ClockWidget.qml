// ClockWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import qs.modules.components
// pragma Singleton
// TODO change fontSize and timeWidth to values that use an alias property
// example: property alias clocktext: tex
// then i can set clocktext.width in other files
Item {
    // Allows for button, text and font size configuration from other files
    property string timeText: Time.time
    property string dateText: Time.date
    property real timeWidth: 30
    property real fontSize: MainConfig.mainFontSize
    property string fontFamily: MainConfig.mainFontFamily
    property bool initialBool: true
    id: root
    RoundButton {
        anchors.centerIn: tex
        anchors.fill: tex.content
        width: tex.contentWidth + MainConfig.mainFontSize * 0.85
        height: tex.contentHeight + MainConfig.mainFontSize * 0.8
        radius: width/2
        flat: true
        opacity: 0.25
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
        styledFontFamily: fontFamily
        styledFontSize: fontSize
        width: timeWidth
    }
}