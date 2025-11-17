import QtQuick
import Quickshell
import qs.modules

Text {
    property real styledFontSize: MainConfig.mainFontSize
    property string styledFontFamily: MainConfig.mainFontFamily
    property color textColor: MainConfig.mainText
    property string textIn: "N/A"
    property var wrapOption: Text.Wrap
    wrapMode: wrapOption
    text: textIn
    color: textColor
    font.family: styledFontFamily
    font.pointSize: styledFontSize
    renderType: Text.NativeRendering
    font.hintingPreference: Font.PreferFullHinting
}