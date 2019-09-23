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

            ctx.moveTo(0, height);
            ctx.lineTo(width / 2, 0);
            ctx.lineTo(width, height);

            ctx.stroke();
            ctx.restore();
        }
    }
}
