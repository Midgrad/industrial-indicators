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
    property real startValue: minValue

    property bool mirrored: false
    property bool labelBorder: true
    property bool shading: false

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
        return Helper.mapToRange(val, minValue, maxValue, repeater.height) - (labelBorder ? label.height / 2 : 0);
    }

    function mapFromRange(pos) {
        return Helper.mapFromRange(pos, minValue, maxValue, repeater.height) + (labelBorder ? label.height / 2 : 0);
    }

    implicitWidth: label.implicitWidth + tickMajorSize * 2

    Hatch {
        id: hatch
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.min(repeater.height, Math.max(mapToRange(warningValue)))
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
        color: backgroundColor
    }

    Rectangle {
        id: shadingLine
        visible: shading
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: repeater.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: scaleColor }
            GradientStop { position: 1.0; color: "transparent" }
        }
        y: labelBorder ? label.height / 2 : 0
    }

    Rectangle {
        id: line
        visible: !shading
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWidth
        height: repeater.height
        color: scaleColor
        y: labelBorder ? label.height / 2 : 0
    }

    Repeater {
        id: repeater
        height: root.height - (labelBorder ? label.height : 0)
        model: {
            var vals = [];
            var startVal = startValue + (startValue > 0 ? startValue % (valueStep / 2) : -startValue % (valueStep / 2));
            vals.push(startValue);
            // to save even index of major marks
            if (startValue % (valueStep / 2) != startValue % valueStep) {
                vals.push(startValue);
            }

            if (valueStep == 0) {
                return vals;
            }
            for (var val = startVal; val <= maxValue; val += (valueStep / 2)) {
                vals.push(val);
            }
            vals.push(maxValue);
            return vals;
        }

        LadderTick {
            property bool coverage: y >= label.y && y <= label.y + label.height
            property bool extreme: value == minValue || value == maxValue

            anchors.left: mirrored ? line.right : parent.left
            anchors.right: mirrored ? parent.right : line.left
            y: repeater.height - mapToRange(value)
            visible: !coverage || extreme
            value: modelData
            major: index % 2 == 0 || extreme
            sign: (index % 2 == 0 || extreme) && !coverage
            mirrored: root.mirrored
            opacity: shading ? Math.sin(y / root.height * Math.PI) : 1
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
        y: (isNaN(value) ? repeater.height / 2 : repeater.height - mapToRange(value)) - height / 2
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
