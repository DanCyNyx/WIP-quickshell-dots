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
    property real itemWidth: (MainConfig.text.fontSize*1.2)
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
            property string names: modelData.name
            property string actives: modelData.active
            property string color1: MainConfig.colors.text
            // property string rectcolor: "transparent"
            readonly property bool isurgent: modelData.urgent //&& HyprlandWorkspace.id == root.names
            readonly property bool isworkspaceactive: Hyprland.focusedWorkspace.name == root.names
            readonly property bool isSpecial: names.includes("special")
            // breaks things anchors.fill: parent
            implicitWidth: itemWidth
            implicitHeight: itemHeight       
            Rectangle {
                id: textbg
                anchors.fill: textmouse
                color: isworkspaceactive? MainConfig.colors.text : isurgent?  MainConfig.colors.secondary : MainConfig.colors.inactiveWorkspace // 
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
                    // Have to click on the special workspace's button again to toggle it off
                    if (isSpecial) {
                        HyprData.hyprDispatch(`togglespecialworkspace ${root.names.split(":")[1]}`);
                    }
                    else { 
                        if (Hyprland.focusedWorkspace.name != root.names) HyprData.hyprDispatch(`workspace ${root.names}`);
                        else return 
                    }
                }
                // Component.onCompleted: {
                //     console.log("workspace name", root.isworkspaceactive)
                // }
                Rectangle {
                    id: textbgoverlay
                    anchors.fill: parent
                    radius: textbg.radius
                    color: "transparent"
                    opacity: 0.4
                }
            }
            // text for the workspace names
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
                text: root.names
                topPadding: itemHeight*0.13
                font.pointSize: MainConfig.mainFontSize
                color: !isworkspaceactive ? MainConfig.mainText : MainConfig.mainColor
            }*/
        }
    }
}
