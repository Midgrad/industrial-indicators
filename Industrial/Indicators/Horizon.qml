import QtQuick 2.6
import Industrial.Indicators 1.0

import "../Controls/helper.js" as Helper

Item {
    id: root

    property real pitch: 0.0
    property real roll: 0.0
    property real minPitch: -25.0
    property real maxPitch: 25.0
    property real effectiveHeight: height

    Rectangle {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: effectiveHeight / 2 - Helper.mapToRange(
                                          -pitch, minPitch, maxPitch, effectiveHeight)
        width: 10000
        height: 10000
        rotation: -roll
        color: Theme.textColor

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 2 - 0.5
            color: enabled ? Theme.skyColor : "#c6c9d1" // TODO: industrial.colors
            Behavior on color { ColorAnimation { duration: 200 } }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 2 - 0.5
            color: enabled ? Theme.groundColor : "#798f99" // TODO: industrial.colors
            Behavior on color { ColorAnimation { duration: 200 } }
        }
    }
}
