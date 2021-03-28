import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property bool mirrored: false

    property alias color: tick.color
    property alias tickSize: tick.width
    property alias tickWidth: tick.height
    property alias labeled: label.visible

    property real value: 0
    property real textOffset: 10
    property real tickFontSize: 12
    property int digits: 0

    Rectangle {
        id: tick
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: textOffset
        horizontalAlignment: mirrored ? Text.AlignLeft : Text.AlignRight
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
        font.pixelSize: tickFontSize
        color: root.color
    }
}
