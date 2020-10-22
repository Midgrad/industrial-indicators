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

    function mapToRange(val) {
        return Helper.mapToRange(val, minValue, maxValue, height);
    }

    function mapFromRange(pos) {
        return Helper.mapFromRange(pos, minValue, maxValue, height);
    }

    implicitWidth: label.implicitWidth + tickMajorSize * 2

    Hatch {
        id: hatch
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: mapToRange(warningValue)
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
        id: line
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: parent.height
        gradient:  Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: scaleColor }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    Repeater {
        id: repeater
        model: {
            var vals = [];
            for (var val = minValue - (minValue % valueStep); val <= maxValue;
                 val += (valueStep / 2)) {
                vals.push(val);
            }
            return vals;
        }

        LadderTick {
            anchors.left: mirrored ? line.right : parent.left
            anchors.right: mirrored ? parent.right : line.left
            y: root.height - mapToRange(value)
            visible: y < label.y || y > label.y + label.height
            value: modelData
            major: index % 2 == 0
            mirrored: root.mirrored
            opacity: Math.sin(y / root.height * Math.PI)
        }
    }

    LadderTick {
        width: root.width
        y: root.height - mapToRange(value)
        visible: errorVisible
        value: root.value + error
        major: y < label.y || y > label.y + label.height
        mirrored: root.mirrored
        color: Theme.activeColor
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
        y: (isNaN(value) ? root.height / 2 : root.height - mapToRange(value)) - height / 2
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
