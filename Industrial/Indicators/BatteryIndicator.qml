import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0

PercentageIndicator {
    id: root

    implicitWidth: Theme.baseSize
    implicitHeight: width

    ColoredIcon {
        anchors.fill: parent
        color: root.color
        source: "qrc:/icons/ind_battery.svg"
    }

    Item {
        id: fill
        anchors.fill: parent
        anchors.margins: root.width * 0.1
        anchors.topMargin: root.width * 0.33

        Text {
            id: textItem
            text: percentage
            font.pixelSize: fill.height * 0.75
            font.bold: true
            anchors.centerIn: parent
            color: root.color
        }

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: fill.height * percentageBordered / 100
            color: root.color
            clip: true

            Text {
                text: textItem.text
                font.pixelSize: textItem.font.pixelSize
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -1
                color: Theme.backgroundColor
            }
        }
    }
}
