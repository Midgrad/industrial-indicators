import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property bool mirrored: false
    property bool major: true
    property color color: scaleColor

    Rectangle {
        id: tick
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: major ? tickMajorSize : tickMinorSize
        height: major ? tickMajorWidth : tickMinorWidth
        color: root.color
    }
}
