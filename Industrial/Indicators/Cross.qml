import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0

Item {
    id: cross
    property real effectiveHeight: height

    property color markColor: Theme.textColor
    property color shadowColor: "black"
    property real markWidth: 2

    implicitHeight: width
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onMarkColorChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        visible: false

        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.lineWidth = markWidth;
            ctx.strokeStyle = markColor;

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

    DropShadow {
        anchors.fill: canvas
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: shadowColor
        source: canvas
    }
}

