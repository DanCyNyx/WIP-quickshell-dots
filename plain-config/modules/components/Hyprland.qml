import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

// File to access data from hyprland ipc
Variants {
    id: root
    model: Hyprland.workspaces
    delegate: Item {
        id: disp
        property bool isurgentmodel: modelData.urgent
        property bool isurgent: HyprlandWorkspace.urgent
        property int ids: modelData.id
        property int idwork: HyprlandWorkspace.id
        Component.onCompleted: {
            console.log("Urgency with Hyprland", isurgentmodel)
            console.log("Urgency with Workspace", isurgent)
            console.log("id with Hyprland", ids)
            console.log("id with Workspace", idwork)
        }
    }
}