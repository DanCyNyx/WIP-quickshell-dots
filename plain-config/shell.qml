import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.modules
import qs.modules.components
/* TODO Full shell: add functionality to switch between the vertical bar and horizontal bar
* and also add an outer rim and rounded corners (like in caelestia dots)
*/
ShellRoot {
    Loader {
        active: MainConfig.shell.horiBarActive
        source: "Bar.qml"
    }
    Loader {
        active: true
        source: "./modules/Background.qml"
    }
    Loader {
        active: MainConfig.shell.vertBarActive
        source: "VerticalBar.qml"
    }
    
}