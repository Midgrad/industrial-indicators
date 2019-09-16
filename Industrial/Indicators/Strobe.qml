import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0

Item {
    id: cross
    property real effectiveHeight: height

    property color color: Theme.textColor
    property color shadowColor: "black"
    property real thickness: 2
    property var dash: []

    implicitHeight: width
    implicitWidth: height
    antialiasing: true

    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onColorChanged: canvas.requestPaint()
    onThicknessChanged: canvas.requestPaint()
    onDashChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        visible: false

        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.lineWidth = thickness;
            ctx.strokeStyle = color;
            ctx.setLineDash(dash);

            ctx.save();
            ctx.beginPath();

            ctx.moveTo(0, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height);
            ctx.lineTo(0, height);
            ctx.closePath();

            ctx.stroke();
            ctx.restore();
        }
    }

    DropShadow {
        anchors.fill: canvas
        horizontalOffset: 1
        verticalOffset: 1
        radius: parent.thickness + 1
        color: shadowColor
        source: canvas
    }
}

