import QtQuick 2.6
import Industrial.Indicators 1.0

LinearScale {
    id: root

    property string tipText

//    model: [12, 10, 6, 3, 2, 1, 0, -1, -2, -3, -6, -10, -12]

    mirrored: true
    minValue: -16
    maxValue: 16
    valueStep: 3
    shading: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    ToolTip {
        visible: text ? mouseArea.containsMouse : false
        text: tipText
    }
}
