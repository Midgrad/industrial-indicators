import QtQuick 2.6

Item {
    id: root

    property real value: 0
    property int digits: 0
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

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: textOffset
        horizontalAlignment: mirrored ? Text.AlignLeft : Text.AlignRight
        visible: major
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
        font.pixelSize: scaleFontSize
        color: root.color
    }
}
