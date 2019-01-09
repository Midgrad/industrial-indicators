import QtQuick 2.6

import "../Controls/helper.js" as Helper

Item {
    id: root

    property real speed: 0
    property real maxSpeed: 30 // TODO: in settings
    property int fix: -1
    property color color: {
        switch (fix) {
        case -1:
        case 0: return industrial.colors.background;
        case 1: return industrial.colors.dangerColor;
        case 2: return industrial.colors.cautionColor;
        case 3:
        default: return industrial.colors.positiveColor;
        }
    }

    onSpeedChanged: canvas.requestPaint()
    onFixChanged: canvas.requestPaint()
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.save();
            ctx.translate(width / 2, height / 2);

            ctx.strokeStyle = color;
            ctx.fillStyle = color;
            ctx.textBaseline = 'middle';
            ctx.textAlign = 'center';

            var offset = Math.min(speed, maxSpeed) / maxSpeed * height / 2;

            ctx.beginPath();
            ctx.lineWidth = 4;
            ctx.moveTo(0, 0);
            ctx.lineTo(0, height * 0.1 - offset);
            ctx.stroke();
            ctx.closePath();

            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.moveTo(0, -offset);
            ctx.lineTo(width * 0.05, height * 0.15 - offset);
            ctx.lineTo(0, height * 0.1 - offset);
            ctx.lineTo(-width * 0.05, height * 0.15 - offset);
            ctx.closePath();
            ctx.fill();

            ctx.restore();
        }
    }
}
