import QtQuick 2.6

Item {
    id: root

    property color color: Theme.textColor
    property real thickness: 2

    implicitHeight: width
    implicitWidth: height
    visible: width > 0 && height > 0

    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onColorChanged: canvas.requestPaint()
    onThicknessChanged: canvas.requestPaint()

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

            ctx.moveTo(0, height / 2);
            ctx.lineTo(width, height / 2);
            ctx.moveTo(width / 2, 0);
            ctx.lineTo(width / 2, height);

            ctx.stroke();
            ctx.restore();
        }
    }
}

    //Shape {
    //    id: root

    //    property color color: Theme.textColor
    //    property real thickness: 2

    //    implicitHeight: width
    //    implicitWidth: height
    //    visible: width > 0 && height > 0

    //    ShapePath {
    //        strokeColor: root.color
    //        strokeWidth: root.thickness
    //        fillColor: "transparent"
    //        startX: 0
    //        startY: height / 2
    //        PathLine { x: width; y: height / 2 }
    //    }

    //    ShapePath {
    //        strokeColor: root.color
    //        strokeWidth: root.thickness
    //        fillColor: "transparent"
    //        startX: width / 2
    //        startY: 0
    //        PathLine { x: width / 2; y: height }
    //    }
    //}

