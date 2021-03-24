import QtQuick 2.6
import Industrial.Indicators 1.0

ScaleTick {
    id: root

    property real value: 0
    property int digits: 0
    property bool sign: true

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: textOffset
        horizontalAlignment: mirrored ? Text.AlignLeft : Text.AlignRight
        visible: sign
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
        font.pixelSize: tickFontSize
        color: root.color
    }
}
