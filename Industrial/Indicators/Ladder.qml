import QtQuick 2.6
import Industrial.Indicators 1.0

LinearScale {
    id: root

    property alias tipText: label.tipText
    property alias digits: label.digits
    property alias prefix: label.prefix
    property alias suffix: label.suffix

    property color labelColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor

    implicitWidth: label.implicitWidth + tickMajorSize * 2
    minValueImpl: Helper.floor125(minValue);
    valueStepImpl: Helper.floor125(valueStep / 2);
    dValue: (mapFromRange(label.y + label.height) - mapFromRange(label.y)) / 2

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
        y: {
            if (isNaN(value))
                return root.height / 2;

            return Math.min(root.height, Math.max(0, root.height - mapToRange(value) - height / 2));
        }
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.margins: tickMajorSize
        width: parent.width - tickMajorSize
        operational: root.operational
        value: root.value
        digits: 0
        color: labelColor
    }
}
