import QtQuick 2.6
import Industrial.Indicators 1.0

LinearScale {
    id: root

    property alias tipText: tip.text

    property color arrowColor: enabled ? (operational ? Theme.textColor : Theme.extremeRed) :
                                         Theme.disabledColor

    minValue: -16
    maxValue: 16
    valueStep: 2
    tickMinorSize: tickFontSize * 0.2
    tickMajorSize: tickFontSize * 0.4
    textOffset: tickFontSize * 0.6
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

    Rectangle {
        anchors.left: parent.left
        width: arrow.width / 2
        anchors.top: value > 0 ? arrow.verticalCenter : zeroPosition.verticalCenter
        anchors.bottom: value > 0 ? zeroPosition.verticalCenter : arrow.verticalCenter
        color: value > 0 ? Theme.skyLowColor: Theme.groundHighColor
    }

    IconIndicator {
        id: zeroPosition
        anchors.right: mirrored ? undefined : root.right
        anchors.left: mirrored ? root.left : undefined
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: -tickMinorWidth
        width: textOffset
        height: width
        rotation: mirrored ? 180 : 0
        source: "qrc:/icons/ind_arrow_offset.svg"
        color: scaleColor
    }

    IconIndicator {
        id: arrow
        anchors.right: mirrored ? undefined : root.right
        anchors.left: mirrored ? root.left : undefined
        y: {
            if (isNaN(value))
                return root.height / 2;

            return Math.min(root.height - height,
                            Math.max(0, root.height - mapToRange(value) - height / 2));
        }
        width: tickMajorSize
        height: Theme.baseSize * 2
        rotation: mirrored ? 180 : 0
        source: "qrc:/icons/ind_scale_arrow.svg"
        color: arrowColor
    }
}
