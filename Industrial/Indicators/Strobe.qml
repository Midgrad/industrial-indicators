import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0
import QtQuick.Shapes 1.13

Shape {
    id: root
    property real effectiveHeight: height

    property color color: Theme.textColor
    property color shadowColor: "black"
    property real thickness: 2
    property bool tracking: false

    implicitHeight: width
    implicitWidth: height
    visible: width > 0 && height > 0

    // TODO: relace all canvas crap with shapes
    Shape {
        id: rect
        anchors.fill: parent
        visible: false
        vendorExtensionsEnabled: true

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

    DropShadow {
        anchors.fill: rect
        source: rect
        horizontalOffset: 1
        verticalOffset: 1
        radius: parent.thickness + 1
        color: shadowColor
    }
}

