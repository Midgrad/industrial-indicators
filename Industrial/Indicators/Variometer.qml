import QtQuick 2.6
import Industrial.Indicators 1.0

LinearScale {
    id: root

    property alias tipText: tip.text

    minValue: -15
    maxValue: 15
    valueStep: 2.5
    dValue: (mapFromRange(label.y + label.height) - mapFromRange(label.y)) / 2

    mirrored: true
    shading: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    ToolTip {
        id: tip
        visible: text ? mouseArea.containsMouse : false
    }

    IconIndicator {
        anchors.right: mirrored ? undefined : root.right
        anchors.left: mirrored ? root.left : undefined
        y: label.y
        width: tickMajorSize
        height: label.height
        rotation:  mirrored ? 180 : 0
        source: "qrc:/icons/ind_ladder_arrow.svg"
    }

    ValueLabel {
        id: label
        y: {
            if (isNaN(value))
                return root.height / 2;

            return Math.min(root.height - height,
                            Math.max(0, root.height - mapToRange(value) - height / 2));
        }
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: parent.width
        operational: root.operational
        value: root.value
        digits: 1

        PropertyAnimation on y { duration: 100 }
    }
}
