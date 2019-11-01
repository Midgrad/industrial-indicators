import QtQuick 2.6

Item {
    id: root

    property alias color: tick.color

    Rectangle {
        id: tick
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (height - root.height + 1) / 2
        color: Theme.textColor
        width: tickWeight
        height: tickSize
        antialiasing: true
    }
}
