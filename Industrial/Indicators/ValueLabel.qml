import QtQuick 2.6
import Industrial.Indicators 1.0

OperationalItem {
    id: root

    property int digits: 0
    property real value: NaN
    property bool active: false
    property color color: {
        if (!enabled) return Theme.disabledColor;
        if (!operational) return Theme.extremeRed;
        if (active) return Theme.activeColor;
        return Theme.textColor;
    }

    property alias prefix: prefixText.text
    property alias suffix: suffixText.text
    property alias valueText: valueText.text
    property string tipText
    property alias prefixFont: prefixText.font
    property alias suffixFont: suffixText.font
    property alias valueFont: valueText.font

    implicitWidth: Math.max(prefixText.implicitWidth, valueText.implicitWidth,
                            suffixText.implicitWidth)
    implicitHeight: (prefix.length > 0 ? prefixText.implicitHeight * 0.75 : 0) +
                    valueText.implicitHeight + (suffix.length > 0 ? suffixText.implicitHeight : 0)

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        Text {
            id: prefixText
            anchors.top: parent.top
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            font.bold: true
            font.pixelSize: Theme.fontSize * 0.8
            visible: prefix.length > 0
        }

        Text {
            id: valueText
            anchors.top: prefixText.bottom
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            font.bold: true
            font.pixelSize: Theme.fontSize
            text: isNaN(value) ? qsTr("N/D") : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
        }

        Text {
            id: suffixText
            anchors.bottom: parent.bottom
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            font: prefixText.font
            visible: suffix.length > 0
        }
    }

    ToolTip {
        visible: text ? mouseArea.containsMouse : false
        text: tipText
    }
}

