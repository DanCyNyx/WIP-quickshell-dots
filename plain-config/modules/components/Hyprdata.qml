import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
pragma Singleton
pragma ComponentBehavior: Bound

// File to access data from hyprland
Singleton {
    id: root
    // code gotten from Soramane's caelestia-shell repo
    // ObjectModels
    readonly property var allWorkspaces: Hyprland.workspaces
    readonly property var allMonitors: Hyprland.monitors
    readonly property var allTopLevels: Hyprland.toplevels
    // Individual properties obtained through hyprland ipc
    readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
    readonly property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
    readonly property HyprlandToplevel activeTopLevel: Hyprland.activeToplevel
    // code gotten from end_4's illogical-impulse repo
    // Properties that require processes. These get extra info that the hyprland ipc doesn't expose by default
    property var windowList: [] //
    property var windowAddresses: [] //
    property var windowByAddress: ({}) //
    property var hyprLayers: ({})
    property var procWorkspaces:[]
    property var procWorkspacesIds:[]
    property var procWorkspacesById:[]
    /* Timer to check if the values work
    end_4 values seem to take a bit to appear
    Timer {
        interval: 100
        running:true
        onTriggered: console.log("procWorkspacesIds", procWorkspacesIds);
    }
    */
    // Functions
    function hyprDispatch(request: string): void {
        Hyprland.dispatch(request);
    }
    function refreshHyprAll(): void {
        Hyprland.refreshMonitors();
        Hyprland.refreshToplevels();
        Hyprland.refreshWorkspaces();
    }
    function updateWindowList() {
        getClients.running = true;
    }
    function updateLayers() {
        getLayers.running = true;
    }
    function updateWorkspaces() {
        getWorkspaces.running = true;
    }
    function updateHyprAll(){
        updateWorkspaces();
        updateLayers();
        updateWindowList();
    }
    Component.onCompleted: {
        updateHyprAll()
    }
    // functions gotten from end_4's illogical-impulse repo
    Process {
        id: getClients
        command: ["hyprctl", "clients", "-j"]
        stdout: StdioCollector {
            id: clientsCollector
            onStreamFinished: {
                root.windowList = JSON.parse(clientsCollector.text);
                let tempWinByAddress = {};
                for (var i=0; i < root.windowList.length; ++i) {
                    var win = root.windowList[i];
                    tempWinByAddress[win.address]=win;
                }
                root.windowByAddress = tempWinByAddress;
                root.windowAddresses = root.windowList.map(win => win.address);
            }
        }
    }
    Process {
        id: getLayers
        command: ["hyprctl", "layers", "-j"]
        stdout: StdioCollector {
            id: layersCollector
            onStreamFinished: {
                root.hyprLayers=JSON.parse(layersCollector.text);
            }
        }
    }
    Process {
        id: getWorkspaces
        command: ["hyprctl", "workspaces", "-j"]
        stdout: StdioCollector {
            id: workspacesCollector
            onStreamFinished: {
                root.procWorkspaces = JSON.parse(workspacesCollector.text);
                let tempWorkspaceById = {};
                for (var i = 0; i < root.procWorkspaces.length; ++i) {
                    var ws = root.procWorkspaces[i];
                    tempWorkspaceById[ws.id] = ws;
                }
                root.procWorkspacesById = tempWorkspaceById
                root.procWorkspacesIds = root.procWorkspaces.map(ws => ws.id)
            }
        }
    }
}