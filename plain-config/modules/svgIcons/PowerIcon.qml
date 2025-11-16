// Generated from SVG file /home/dani/.config/quickshell/useful-qml-stuff/power-icon.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    implicitWidth: 24
    implicitHeight: 24
    component AnimationsInfo : QtObject
    {
        property bool paused: false
        property int loops: 1
        signal restart()
    }
    property AnimationsInfo animations : AnimationsInfo {}
    transform: [
        Translate { x: 0; y: 960 },
        Scale { xScale: width / 960; yScale: height / 960 }
    ]
    id: __qt_toplevel
    Shape {
        preferredRendererType: Shape.CurveRenderer
        id: _qt_node0
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: "transparent"
            fillColor: "#ff1f1f1f"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 480 -80 C 424.667 -80 372.667 -90.5 324 -111.5 C 275.333 -132.5 233 -161 197 -197 C 161 -233 132.5 -275.333 111.5 -324 C 90.5 -372.667 80 -424.667 80 -480 C 80 -536 90.5 -588.167 111.5 -636.5 C 132.5 -684.833 161 -727 197 -763 L 253 -707 C 223.667 -677.667 200.833 -643.667 184.5 -605 C 168.167 -566.333 160 -524.667 160 -480 C 160 -390.667 191 -315 253 -253 C 315 -191 390.667 -160 480 -160 C 569.333 -160 645 -191 707 -253 C 769 -315 800 -390.667 800 -480 C 800 -524.667 791.833 -566.333 775.5 -605 C 759.167 -643.667 736.333 -677.667 707 -707 L 763 -763 C 799 -727 827.5 -684.833 848.5 -636.5 C 869.5 -588.167 880 -536 880 -480 C 880 -424.667 869.5 -372.667 848.5 -324 C 827.5 -275.333 799 -233 763 -197 C 727 -161 684.667 -132.5 636 -111.5 C 587.333 -90.5 535.333 -80 480 -80 M 440 -440 L 440 -880 L 520 -880 L 520 -440 L 440 -440 " }
        }
    }
}
