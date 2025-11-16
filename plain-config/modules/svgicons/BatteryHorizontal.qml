// Generated from SVG file /home/dani/.config/quickshell/useful-qml-stuff/battery-horizontal.svg
import QtQuick
import QtQuick.Shapes
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import qs
import qs.modules
import qs.modules.components

Item {
    id: _qt_node0

    property AnimationsInfo animations
    property color shapefill: Appearance.mainText

    animations: AnimationsInfo {
    }

    implicitWidth: 960
    implicitHeight: 960
    transform: [
        Scale {
            xScale: width / 960
            yScale: height / 960
        }
    ]
    // Structure node
    Item {
        /*
        Shape {
            objectName: "svg_1"
            id: _qt_node2
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                id: _qt_shapePath_0
                objectName: "svg_path:svg_1"
                strokeColor: "transparent"
                fillColor: "#ff1f1f1f"
                fillRule: ShapePath.WindingFill
                PathSvg { path: "M 200 -280 C 188.667 -280 179.167 -283.833 171.5 -291.5 C 163.833 -299.167 160 -308.667 160 -320 L 160 -400 L 80 -400 L 80 -560 L 160 -560 L 160 -640 C 160 -651.333 163.833 -660.833 171.5 -668.5 C 179.167 -676.167 188.667 -680 200 -680 L 840 -680 C 851.333 -680 860.833 -676.167 868.5 -668.5 C 876.167 -660.833 880 -651.333 880 -640 L 880 -320 C 880 -308.667 876.167 -299.167 868.5 -291.5 C 860.833 -283.833 851.333 -280 840 -280 L 200 -280 M 240 -360 L 800 -360 L 800 -600 L 240 -600 L 240 -360 " }
            }
        }
        */

        id: _qt_node1

        Shape {
            id: _qt_node3

            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                id: _qt_shapePath_1

                strokeColor: "transparent"
                fillColor: shapefill // default "#ff1f1f1f"
                fillRule: ShapePath.WindingFill

                PathSvg {
                    path: "M 200 680 C 188.667 680 179.167 676.167 171.5 668.5 C 163.833 660.833 160 651.333 160 640 L 160 560 L 80 560 L 80 400 L 160 400 L 160 320 C 160 308.667 163.833 299.167 171.5 291.5 C 179.167 283.833 188.667 280 200 280 L 840 280 C 851.333 280 860.833 283.833 868.5 291.5 C 876.167 299.167 880 308.667 880 320 L 880 640 C 880 651.333 876.167 660.833 868.5 668.5 C 860.833 676.167 851.333 680 840 680 L 200 680 M 240 600 L 800 600 L 800 360 L 240 360 L 240 600 "
                }

            }

            transform: TransformGroup {
                id: _qt_node3_transform_base_group

                Matrix4x4 {
                    matrix: PlanarTransform.fromAffineMatrix(-1, 0, 0, -1, 960, 960)
                }

            }

        }

    }

    component AnimationsInfo: QtObject {
        property bool paused: false
        property int loops: 1

        signal restart()
    }

}
