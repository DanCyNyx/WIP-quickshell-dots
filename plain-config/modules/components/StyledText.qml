import QtQuick
import Quickshell
import qs.modules

Text {
    property real fontSize: MainConfig.text.fontSize
    property string fontFamily: MainConfig.text.fontFamily
    property color textColor: MainConfig.colors.text
    property string textIn: "N/A"
    property var wrapOption: Text.Wrap
    wrapMode: wrapOption
    text: textIn
    color: textColor
    font.family: fontFamily
    font.pointSize: fontSize
    renderType: Text.NativeRendering
    font.hintingPreference: Font.PreferFullHinting
}