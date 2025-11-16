// TempWorkspace.qml
// Temporary workspace file for testing stuff till i make a better layout and file
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.modules
import qs.modules.components
// TODO workspace: can use alias instead of directly setting the itemWidth and height and listOrient
Item {
    id: workroot
    property real itemWidth: (MainConfig.mainFontSize*1.2)
    property real itemHeight: itemWidth
    property real rectRad: itemWidth/2
    property var listOrient: ListView.Horizontal
    implicitWidth: itemWidth*14.8
    implicitHeight: itemHeight*14.8
    ListView {
        id: listv
        model: Hyprland.workspaces
        orientation: listOrient
        spacing: 7
        anchors.fill: parent
        // anchors.fill: parent
        delegate: Item {
            id: root
            required property var modelData
            property int ids: modelData.id
            property string actives: modelData.active
            property string color1: MainConfig.mainText
            // property string rectcolor: "transparent"
            readonly property bool isurgent: modelData.urgent //&& HyprlandWorkspace.id == root.ids
            readonly property bool isworkspaceactive: Hyprland.focusedWorkspace.id == root.ids
            // breaks things anchors.fill: parent
            implicitWidth: itemWidth
            implicitHeight: itemHeight
            /* Component.onCompleted: {
                console.log("Urgency", isurgent)
            }*/          
            Rectangle {
                id: textbg
                anchors.fill: textmouse
                color: isworkspaceactive? MainConfig.mainText : isurgent?  MainConfig.secondaryColor : MainConfig.inactiveWorkspace // 
                radius: rectRad
                opacity:isworkspaceactive? 0.9 : isurgent? 0.7 : 1
                // TODO Workspaces: add a blinking animation to urgent workspaces
            }
            MouseArea {
                id: textmouse
                anchors.fill: root
                hoverEnabled: true
                onEntered: {
                    textbgoverlay.color = "black";
                    //texts.color = "red"; //Qt.binding(function(){return color1})
                }
                onExited: {
                    textbgoverlay.color = "transparent";
                    //texts.color = Qt.binding(function(){return !isworkspaceactive ? MainConfig.mainText : MainConfig.mainColor})
                }
                onClicked: {
                    if (Hyprland.focusedWorkspace.id != root.ids) HyprData.hyprDispatch(`workspace ${root.ids}`)
                    else return
                }
                
                Rectangle {
                    id: textbgoverlay
                    anchors.fill: parent
                    radius: textbg.radius
                    color: "transparent"
                    opacity: 0.4
                }
            }
            // text for the workspace ids
            /*
            Text {
                id: texts
                font.family: MainConfig.mainFontFamily
                anchors.centerIn: parent
                // anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                text: root.ids
                topPadding: itemHeight*0.13
                font.pointSize: MainConfig.mainFontSize
                color: !isworkspaceactive ? MainConfig.mainText : MainConfig.mainColor
            }*/
        }
    }
}
