import QtQuick 2.6
import QtQuick.Shapes 1.0

Shape {
    id: root

    property color color: Theme.textColor
    property real thickness: 2

    implicitHeight: width
    implicitWidth: height
    visible: width > 0 && height > 0

    ShapePath {
        strokeColor: root.color
        strokeWidth: root.thickness
        fillColor: "transparent"
        startX: 0
        startY: height / 2
        PathLine { x: width; y: height / 2 }
    }

    ShapePath {
        strokeColor: root.color
        strokeWidth: root.thickness
        fillColor: "transparent"
        startX: width / 2
        startY: 0
        PathLine { x: width / 2; y: height }
    }
}

