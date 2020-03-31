import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property color color: enabled ? Theme.activeColor : Theme.disabledColor
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

    property real _x0: feedback.x //(width - handle.width) / 2
    property real _y0: feedback.y //(height - handle.height) / 2

    implicitHeight: width
    implicitWidth: height

    // Circle
    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.color: root.color
        border.width: 2
    }

    // Square in circle
    Rectangle {
        id: joystickSquare
        x: root.width / 2 - root.width / 4 / Math.sin(Math.PI / 4)
        y: root.height / 2 - root.height / 4 / Math.sin(Math.PI / 4)
        height: root.height / 2 / Math.sin(Math.PI / 4)
        width: root.width / 2 / Math.sin(Math.PI / 4)
        color: "transparent"
        border.color: root.color
        border.width: 2
    }

    Rectangle {
        id: horizontalStick
        x: joystickSquare.x
        y: handle.y
        height: joystickSquare.height / 3
        radius: height / 2
        width: joystickSquare.width
        color: "transparent"
        border.color: root.color
        border.width: 2
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
            x: joystickSquare.x + Helper.mapToRange(modelData, minX, maxX, joystickSquare.width)
            y: horizontalStick.y + horizontalStick.height / 2  - height / 2
            height: joystickSquare.height * tickFactor
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
            y: joystickSquare.y + Helper.mapToRange(modelData, minY, maxY, joystickSquare.height)
            x: (parent.width - width) / 2
            width: joystickSquare.height * tickFactor
            height: 1
            color: root.color
            opacity: opacityFactor - Math.abs(modelData / (maxY - minY))
        }
    }

    ColoredIcon {
        id: feedback
        x: joystickSquare.x + Helper.mapToRange(feedbackX, minX, maxX, (joystickSquare.width - feedback.width))
        y: joystickSquare.y + Helper.mapToRange(feedbackY, minY, maxY, (joystickSquare.height - feedback.height))
        height: horizontalStick.height
        width: height
        opacity: opacityFactor
        color: root.color
        source: "qrc:/icons/ind_aim.svg"
    }

    ColoredIcon {
        id: handle
        x: _x0
        y: _y0
        height: horizontalStick.height
        width: height
        color: root.color
        onXChanged: xDeviation(Helper.mapFromRange(handle.x - joystickSquare.x, minX, maxX, (joystickSquare.width - handle.width)))
        onYChanged: yDeviation(Helper.mapFromRange(handle.y - joystickSquare.y, minY, maxY, (joystickSquare.height - handle.height)))
        source: "qrc:/icons/ind_stick.svg"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: handle
        drag.axis: Drag.XAndYAxis
        drag.minimumX: joystickSquare.x
        drag.maximumX: joystickSquare.x + joystickSquare.width - handle.width
        drag.minimumY: joystickSquare.y
        drag.maximumY: joystickSquare.y + joystickSquare.height - handle.height
        onReleased: {
            handle.x = Qt.binding(function() { return _x0; });
            handle.y = Qt.binding(function() { return _y0; });
        }
    }
}
