import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0

Item {
    id: root

    property alias source: image.source
    property alias mirror: image.mirror
    property alias color: overlay.color
    property string tipText

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

    ToolTip {
        visible: text ? mouseArea.containsMouse : false
        text: tipText
    }
}

