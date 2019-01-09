import QtQuick 2.6

Item {
    id: root

    property string prefix
    property int digits: 0
    property real value: NaN
    property bool operational: true
    property bool active: false
    property color color: {
        if (!enabled) return industrial.colors.background;
        if (!operational) return industrial.colors.dangerColor;
        if (active) return industrial.colors.activeMissionColor;
        return industrial.colors.onSurface;
    }

    property alias prefixFont: prefixText.font
    property alias valueFont: valueText.font

    implicitWidth: Math.max(prefixText.implicitWidth, valueText.implicitWidth)
    implicitHeight: (prefix.length > 0 ? prefixText.implicitHeight : 0) + valueText.implicitHeight

    Text {
        id: prefixText
        anchors.top: parent.top
        width: root.width
        horizontalAlignment: Text.AlignHCenter
        color: root.color
        font.bold: true
        font.pixelSize: industrial.fontSize * 0.6
        visible: prefix.length > 0
        text: prefix
    }

    Text {
        id: valueText
        anchors.bottom: parent.bottom
        width: root.width
        horizontalAlignment: Text.AlignHCenter
        color: root.color
        font.bold: true
        font.pixelSize: industrial.secondaryFontSize
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
    }
}

