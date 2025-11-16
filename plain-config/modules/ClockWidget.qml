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
    property bool help: true
    id: root
    RoundButton {
        anchors.centerIn: tex
        anchors.fill: tex.content
        // Layout.fillHeight: true
        width: tex.contentWidth + MainConfig.mainFontSize * 0.85
        height: tex.contentHeight + MainConfig.mainFontSize * 0.8
        radius: MainConfig.mainFontSize * 0.8
        flat: true
        opacity: 0.25
        onClicked: {
            tex.text = help ? Qt.binding(function(){return dateText}) : Qt.binding(function(){return timeText})
            help = !help
            // if (tex.text == timeText)
            //     tex.text = Qt.binding(function(){return dateText})
            // else
            //     tex.text = tex.text = Qt.binding(function(){return timeText})
        }
    }
    Text {
        id: tex
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: timeText
        font.family:MainConfig.mainFontFamily
        font.pointSize: fontSize
        wrapMode: Text.Wrap
        width: timeWidth
        color: MainConfig.mainText
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
    }
}