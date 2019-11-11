import QtQuick 2.6
import QtGraphicalEffects 1.0
import Industrial.Indicators 1.0


Item {
    id: root

    property alias source: image.source
    property alias mirror: image.mirror
    property alias color: overlay.color
    rotation: mirror ? 180 : 0


    implicitWidth: image.sourceSize.width
    implicitHeight: image.sourceSize.height


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

