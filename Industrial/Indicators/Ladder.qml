import QtQuick 2.6
import Industrial.Indicators 1.0

OperationalItem {
    id: root

    property int digits: 0
    property real value: 50
    property real error: 0
    property bool errorVisible: false
    property real warningValue: NaN
    property real minValue: 0
    property real maxValue: 100
    property real valueStep: 10

    property bool mirrored: false

    property alias scaleFontSize: label.prefixFont.pixelSize
    property real tickMinorSize: scaleFontSize * 0.4
    property real tickMajorSize: scaleFontSize * 0.6
    property real textOffset: scaleFontSize * 0.8
    property real tickMajorWidth: 2
    property real tickMinorWidth: 1

    property string prefix
    property string suffix

    property color scaleColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor
    property color labelColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor
    property color hatchColor: Theme.severeOrange
    property color backgroundColor: Theme.backgroundColor

    function mapToRange(val) {
        return Helper.mapToRange(val, minValue, maxValue, repeater.height);
    }

    function mapFromRange(pos) {
        return Helper.mapFromRange(pos, minValue, maxValue, repeater.height);
    }

    implicitWidth: label.implicitWidth + tickMajorSize * 2

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
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: backgroundColor }
            GradientStop { position: 0.5; color: "transparent" }
            GradientStop { position: 1.0; color: backgroundColor }
        }
    }

    Rectangle {
        id: line
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: repeater.height
        y: label.height / 2
    }

    Repeater {
        id: repeater
        height: root.height - label.height
        model: {
            var vals = [];
            vals.push(minValue)
            for (var val = minValue - (minValue % valueStep); val <= maxValue;
                 val += (valueStep / 2)) {
                vals.push(val);
            }
            vals.push(maxValue)
            return vals;
        }

        LadderTick {
            anchors.left: mirrored ? line.right : parent.left
            anchors.right: mirrored ? parent.right : line.left
            y: repeater.height - mapToRange(value) + label.height / 2
            visible: y < label.y || y > label.y + label.height
            value: modelData
            major: index % 2 == 0
            mirrored: root.mirrored
        }
    }

    IconIndicator {
        anchors.right: mirrored ? undefined : root.right
        anchors.left: mirrored ? root.left : undefined
        y: label.y
        width: tickMajorSize
        height: label.height
        rotation:  mirrored ? 180 : 0
        source: "qrc:/icons/ind_ladder_arrow.svg"
        color: labelColor
    }

    ValueLabel {
        id: label
        y: (isNaN(value) ? repeater.height / 2 : repeater.height - mapToRange(value) + label.height / 2) - height / 2
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.margins: tickMajorSize
        width: parent.width - tickMajorSize
        value: root.value
        operational: root.operational
        digits: root.digits
        prefix: root.prefix
        suffix: root.suffix
        color: labelColor
    }
}
