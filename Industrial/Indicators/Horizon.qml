import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property real pitch: 0.0
    property real roll: 0.0
    property real minPitch: -25.0
    property real maxPitch: 25.0
    property real effectiveHeight: height

    property bool online: false

    property color skyHighColor: online ? Theme.skyHighColor : Theme.skyOffHighColor
    property color skyLowColor: online ? Theme.skyLowColor : Theme.skyOffLowColor
    property color groundHighColor: online ? Theme.groundHighColor : Theme.groundOffHighColor
    property color groundLowColor: online ? Theme.groundLowColor : Theme.groundOffLowColor

    Behavior on skyHighColor { ColorAnimation { duration: 200 } }
    Behavior on skyLowColor { ColorAnimation { duration: 200 } }
    Behavior on groundHighColor { ColorAnimation { duration: 200 } }
    Behavior on groundLowColor { ColorAnimation { duration: 200 } }

    Rectangle {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: effectiveHeight / 2 - Helper.mapToRange(
                                          -pitch, minPitch, maxPitch, effectiveHeight)
        width: 10000
        height: 10000
        rotation: -roll
        color: Theme.textColor
        antialiasing: true

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 2 - 0.5
            antialiasing: true
            gradient: Gradient {
                GradientStop { position: 0.97; color: skyHighColor }
                GradientStop { position: 1.0; color: skyLowColor }
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 2 - 0.5
            antialiasing: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: groundHighColor }
                GradientStop { position: 0.03; color: groundLowColor }
            }
        }
    }
}
