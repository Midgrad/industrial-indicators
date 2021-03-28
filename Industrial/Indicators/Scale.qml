import QtQuick 2.6
import Industrial.Indicators 1.0

OperationalItem {
    id: root

    property real value: 0
    property real warningValue: NaN

    property bool mirrored: false
    property bool shading: true

    property real tickFontSize: Theme.fontSize * 0.8;
    property real tickMinorSize: tickFontSize * 0.4
    property real tickMajorSize: tickFontSize * 0.6
    property real textOffset: tickFontSize * 0.8
    property real tickMajorWidth: 2
    property real tickMinorWidth: 1

    property color scaleColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor
    property color hatchColor: Theme.severeOrange
    property color backgroundColor: Theme.backgroundColor

    property alias model: repeater.model
    property alias delegate: repeater.delegate
    property alias line: line

    property var mapToRange: function(value) { return value; }
    property var mapFromRange: function(value) { return value; }

    implicitWidth: tickMajorSize * 2

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    Hatch {
        id: hatch
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.min(root.height, Math.max(mapToRange(warningValue)))
        visible: !isNaN(warningValue)
        color: enabled ? hatchColor : Theme.backgroundColor
        z: -1

        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: tickMajorWidth
            color: parent.color
        }
    }

    Rectangle {
        id: shadingLine
        visible: shading
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: root.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: scaleColor }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    Rectangle {
        id: line
        visible: !shading
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: root.height
        color: scaleColor
    }

    Repeater {
        id: repeater

        delegate: ScaleTick {
            anchors.left: mirrored ? line.right : parent.left
            anchors.right: mirrored ? parent.right : line.left
            y: root.height - mapToRange(value)
            mirrored: root.mirrored
            textOffset: root.textOffset
            tickFontSize: root.tickFontSize
            color: root.scaleColor
            opacity: root.shading ? Math.sin(y / root.height * Math.PI) : 1.0
            value: modelData["value"]
            tickSize: modelData["major"] ? tickMajorSize : tickMinorSize
            tickWidth: modelData["major"] ? tickMajorWidth : tickMinorWidth
            labeled: modelData["major"]
        }
    }
}
