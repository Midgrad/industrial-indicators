import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0
import QtQuick.Controls 2.2 as T

Item {
    id: root

    property alias source: image.source
    property alias mirror: image.mirror
    property alias color: overlay.color
    property alias toolTipText: toolTip.text

    rotation: mirror ? 180 : 0

    implicitWidth: image.sourceSize.width
    implicitHeight: image.sourceSize.height

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        Image {
            id: image
            anchors.fill: parent
            sourceSize.width: width
            sourceSize.height: height
            visible: false
        }

        ColorOverlay {
            id: overlay
            anchors.fill: parent
            source: image
            visible: image.status == Image.Ready
        }
    }

    T.ToolTip {
        id: toolTip
        visible: text ? mouseArea.containsMouse : false

        contentItem: Text {
            text: toolTip.text
            font: toolTip.font
            color: Theme.tipText
            horizontalAlignment: Qt.AlignHCenter
        }

        background: Rectangle {
            color: Theme.tip
            radius: 3
        }
    }
}

