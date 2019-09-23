import QtQuick 2.6
import QtQuick.Shapes 1.0

Shape {
    id: root

    property color color: Theme.textColor
    property real thickness: 2
    property bool tracking: false

    implicitHeight: width
    implicitWidth: height
    visible: width > 0 && height > 0

    ShapePath {
        strokeColor: root.color
        strokeWidth: root.thickness
        fillColor: "transparent"
        strokeStyle: tracking ? ShapePath.SolidLine : ShapePath.DashLine
        dashPattern: [8, 6]

        PathLine { x: width; y: 0 }
        PathLine { x: width; y: height }
        PathLine { x: 0; y: height }
        PathLine { x: 0; y: 0 }
    }
}

