import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property real heading: 0.0
    property real fov: 0.0

    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
    onFovChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: heading
        opacity: 0.5

        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.save();
            ctx.translate(width / 2, height / 2);

            ctx.strokeStyle = Theme.missionColor;
            ctx.fillStyle = Theme.missionColor;

            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.arc(0, 0, height / 2, (-90) * Math.PI / 180, (fov - 90) * Math.PI / 180, false);
            ctx.lineTo(0, 0);
            ctx.fill();

            ctx.restore();
        }
    }
}
