import QtQuick 2.6
import Industrial.Indicators 1.0
import QtQuick.Controls 2.2 as T

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
    property alias valueText: valueText.text
    property string tipText
    property alias prefixFont: prefixText.font
    property alias valueFont: valueText.font

    implicitWidth: Math.max(prefixText.implicitWidth, valueText.implicitWidth)
    implicitHeight: (prefix.length > 0 ? prefixText.implicitHeight * 0.75 : 0) + valueText.implicitHeight

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
            anchors.bottom: parent.bottom
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            color: root.color
            font.bold: true
            font.pixelSize: Theme.fontSize
            text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
        }
    }

    ToolTip {
        visible: text ? mouseArea.containsMouse : false
        text: tipText
    }
}

