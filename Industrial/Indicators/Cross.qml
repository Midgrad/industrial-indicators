import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0

Item {
    id: root
    property real effectiveHeight: height

    property color color: Theme.textColor
    property color shadowColor: "black"
    property real thickness: 1

    implicitHeight: width
    implicitWidth: height
    antialiasing: true

    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onColorChanged: canvas.requestPaint()
    onThicknessChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        visible: false

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

    // TODO: common indicators drop shadow
    DropShadow {
        anchors.fill: canvas
        horizontalOffset: 1
        verticalOffset: 1
        radius: parent.thickness + 1
        color: shadowColor
        source: canvas
    }
}

