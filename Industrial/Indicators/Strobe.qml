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

    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onColorChanged: canvas.requestPaint()
    onThicknessChanged: canvas.requestPaint()
    onTrackingChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.lineWidth = thickness;
            ctx.strokeStyle = color;

            ctx.save();

            ctx.beginPath();

            if (tracking) {
                ctx.setLineDash([]);
            }
            else {
                ctx.setLineDash([10, 10]);
            }

            ctx.moveTo(0, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height);
            ctx.lineTo(0, height);
            ctx.closePath();

            ctx.stroke();
            ctx.restore();
        }
    }

//    ShapePath {
//        strokeColor: root.color
//        strokeWidth: root.thickness
//        fillColor: "transparent"
//        strokeStyle: tracking ? ShapePath.SolidLine : ShapePath.DashLine
//        dashPattern: [8, 6]

//        PathLine { x: width; y: 0 }
//        PathLine { x: width; y: height }
//        PathLine { x: 0; y: height }
//        PathLine { x: 0; y: 0 }
//    }
}

