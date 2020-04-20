import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0

PercentageIndicator {
    id: root

    implicitWidth: height + label.width
    implicitHeight: Theme.baseSize*2

    IconIndicator {
        anchors.left: parent.left
        height: parent.height
        width: height
        color: root.color
        source: "qrc:/icons/ind_fuel.svg"
    }

    Text {
        id: label
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.percentage + "%"
        color: root.color
        font.bold: true
        font.pixelSize: root.height * 0.33
    }
}
