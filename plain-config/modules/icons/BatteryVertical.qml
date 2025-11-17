// Generated from SVG file /home/dani/.config/quickshell/useful-qml-stuff/battery-vertical.svg
import QtQuick
import QtQuick.Shapes
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import qs
import qs.modules
import qs.modules.components

Item {
    id: __qt_toplevel

    property AnimationsInfo animations
    property color shapefill: MainConfig.mainText
    animations: AnimationsInfo {
    }

    implicitWidth: 24
    implicitHeight: 24
    transform: [
        Translate {
            x: 0
            y: 960
        },
        Scale {
            xScale: width / 960
            yScale: height / 960
        }
    ]
    Shape {
        id: _qt_node0

        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: _qt_shapePath_0

            strokeColor: "transparent"
            fillColor: shapefill // default "#ff1f1f1f"
            fillRule: ShapePath.WindingFill

            PathSvg {
                path: "M 320 -80 C 308.667 -80 299.167 -83.8333 291.5 -91.5 C 283.833 -99.1667 280 -108.667 280 -120 L 280 -760 C 280 -771.333 283.833 -780.833 291.5 -788.5 C 299.167 -796.167 308.667 -800 320 -800 L 400 -800 L 400 -880 L 560 -880 L 560 -800 L 640 -800 C 651.333 -800 660.833 -796.167 668.5 -788.5 C 676.167 -780.833 680 -771.333 680 -760 L 680 -120 C 680 -108.667 676.167 -99.1667 668.5 -91.5 C 660.833 -83.8333 651.333 -80 640 -80 L 320 -80 M 360 -160 L 600 -160 L 600 -720 L 360 -720 L 360 -160 "
            }

        }

    }

    component AnimationsInfo: QtObject {
        property bool paused: false
        property int loops: 1

        signal restart()
    }

}
