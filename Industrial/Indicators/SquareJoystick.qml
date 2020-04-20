import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property color color: enabled ? (incorrectValues ? Theme.dangerColor : Theme.textColor) : Theme.disabledColor
    property real opacityFactor: 0.75
    property real handleFactor: 0.33

    property real minX: -1
    property real maxX: 1
    property real minY: -1
    property real maxY: 1
    property real ticksY: 5
    property real feedbackX: (maxX - minX) / 2
    property real feedbackY: (maxY - minY) / 2
    readonly property bool incorrectValues: feedbackX < minX || feedbackX > maxX || feedbackY < minY || feedbackY > maxY

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
        border.width: 3
    }

    Rectangle {
        id: horizontalStick
        visible: !incorrectValues
        x: joystickSquare.x
        y: handle.y
        height: joystickSquare.height * handleFactor
        radius: height / 2
        width: joystickSquare.width
        color: "transparent"
        border.color: root.color
        border.width: 3
    }

    Repeater {
        model: {
            var ticks = [];
            if (minY >= maxY) return ticks;
            var middle = (maxY + minY) / 2;
            var step = (maxY - minY) / 2 / ticksY;
            var maxHeight = (root.width / 2 - joystickSquare.width / 2) * 0.8
            for(var i = 0; i <= ticksY; i+=1 ) {
                if(i === 0) {
                    ticks.push([middle, maxHeight, 3]);
                }
                else {
                    ticks.push([middle + step * i, maxHeight * (ticksY - i) / ticksY, 2]);
                    ticks.push([middle - step * i, maxHeight * (ticksY - i) / ticksY, 2]);
                }
            }
            return ticks;
        }

        Item {
            Rectangle {
                y: joystickSquare.y + Helper.mapToRange(modelData[0], minY, maxY, joystickSquare.height)
                x: joystickSquare.x - width
                width: modelData[1]
                height: modelData[2]
                color: root.color
                opacity: opacityFactor - Math.abs(modelData[0] / (maxY - minY))
            }

            Rectangle {
                y: joystickSquare.y + Helper.mapToRange(modelData[0], minY, maxY, joystickSquare.height)
                x: joystickSquare.x + joystickSquare.width
                width: modelData[1]
                height: modelData[2]
                color: root.color
                opacity: opacityFactor - Math.abs(modelData[0] / (maxY - minY))
            }
        }
    }

    // Top and Bottom ticks
    Item {
        Rectangle {
            y: joystickSquare.y - height
            x: joystickSquare.x + joystickSquare.width / 2 - width / 2
            width: 3
            height: (root.width / 2 - joystickSquare.width / 2) * 0.8
            color: root.color
            opacity: opacityFactor
        }

        Rectangle {
            y: joystickSquare.y + joystickSquare.height
            x: joystickSquare.x + joystickSquare.width / 2 - width / 2
            width: 3
            height: (root.width / 2 - joystickSquare.width / 2) * 0.8
            color: root.color
            opacity: opacityFactor
        }
    }

    Item {
        id: feedback
        visible: !incorrectValues && (x != handle.x || y != handle.y)
        x: joystickSquare.x + Helper.mapToRange(feedbackX, minX, maxX, (joystickSquare.width - feedback.width))
        y: joystickSquare.y + Helper.mapToRange(feedbackY, minY, maxY, (joystickSquare.height - feedback.height))
        height: horizontalStick.height
        width: height

        Rectangle {
            anchors.centerIn: feedback
            height: horizontalStick.height / 4
            width: height
            radius: width / 2
            color: enabled ? Theme.activeColor : Theme.disabledColor
        }
    }

    IconIndicator {
        id: handle
        visible: !incorrectValues
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
