import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property color color: Theme.missionColor

    property real handleFactor: 0.2
    property real tickFactor: 0.1
    property real opacityFactor: 0.75

    property real minX: -1
    property real maxX: 1
    property real minY: -1
    property real maxY: 1
    property real ticksX: 10
    property real ticksY: 10
    property real feedbackX: (maxX - minX) / 2
    property real feedbackY: (maxY - minY) / 2

    property alias feedbackVisible: feedback.visible

    signal xDeviation(real x)
    signal yDeviation(real y)

    property real _x0: (width - handle.width) / 2
    property real _y0: (height - handle.height) / 2

    implicitHeight: width
    implicitWidth: height

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.color: root.color
        border.width: 1
    }

    Repeater {
        model: {
            var ticks = [];
            if (minX >= maxX) return ticks;
            for (var i = minX; i <= maxX; i += (maxX - minX) / ticksX) {
                ticks.push(i);
            }
            return ticks;
        }

        Rectangle {
            x: Helper.mapToRange(modelData, minX, maxX, root.width)
            y: (parent.height - height) / 2
            height: root.height * tickFactor
            width: 1
            color: root.color
            opacity: opacityFactor - Math.abs(modelData / (maxX - minX))
        }
    }

    Repeater {
        model: {
            var ticks = [];
            if (minY >= maxY) return ticks;
            for (var i = minY; i <= maxY; i += (maxY - minY) / ticksY) {
                ticks.push(i);
            }
            return ticks;
        }

        Rectangle {
            y: Helper.mapToRange(modelData, minY, maxY, root.height)
            x: (parent.width - width) / 2
            width: root.width * tickFactor
            height: 1
            color: root.color
            opacity: opacityFactor - Math.abs(modelData / (maxY - minY))
        }
    }

    Rectangle {
        id: feedback
        x: Helper.mapToRange(feedbackX, minX, maxX, (root.width - feedback.width))
        y: Helper.mapToRange(feedbackY, minY, maxY, (root.height - feedback.height))
        height: root.height * handleFactor
        width: height
        radius: width / 2
        color: root.color
        opacity: opacityFactor
    }

    Rectangle {
        id: handle
        x: _x0
        y: _y0
        height: root.height * handleFactor
        width: height
        radius: width / 2
        color: "transparent"
        border.color: root.color
        border.width: 2
        onXChanged: xDeviation(Helper.mapFromRange(handle.x, minX, maxX, (root.width - handle.width)))
        onYChanged: yDeviation(Helper.mapFromRange(handle.y, minY, maxY, (root.height - handle.height)))
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: handle
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0
        drag.maximumX: parent.width - handle.width
        drag.minimumY: 0
        drag.maximumY: parent.height - handle.height
        onReleased: {
            handle.x = Qt.binding(function() { return _x0; });
            handle.y = Qt.binding(function() { return _y0; });
        }
    }
}
