import QtQuick 2.6
import Industrial.Indicators 1.0

Scale {
    id: root

    property string tipText
    property int digits: 0
    property string prefix
    property string suffix

    property color labelColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor

    implicitWidth: label.implicitWidth + tickMajorSize * 2

    delegate: LadderTick {
        property bool extreme: value === minValue || value === maxValue

        anchors.left: mirrored ? line.right : parent.left
        anchors.right: mirrored ? parent.right : line.left
        y: root.height - mapToRange(value)
        value: modelData
        major: index % 2 === 0 || extreme
        sign: (index % 2 === 0 || extreme)
        mirrored: root.mirrored
        opacity: shading ? Math.sin(y / root.height * Math.PI) : 1
    }

    Rectangle {
        anchors.fill: label
        anchors.leftMargin: mirrored ? tickMinorWidth - tickMajorSize : 0
        anchors.rightMargin: mirrored ? 0 : tickMinorWidth - tickMajorSize
        color: backgroundColor
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
        y: {
            if (isNaN(value))
                return root.height / 2;

            var pos = root.height - mapToRange(value) - height / 2;
            return Math.min(root.height, Math.max(0, pos));
        }
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.margins: tickMajorSize
        width: parent.width - tickMajorSize
        operational: root.operational
        value: root.value
        digits: root.digits
        prefix: root.prefix
        suffix: root.suffix
        color: labelColor
        tipText: tipText
    }
}
