import QtQuick 2.6
import QtGraphicalEffects 1.0

OperationalItem {
    id: ai

    property real pitch: 0.0
    property real roll: 0.0

    property real maxPitch: 23
    property real minPitch: -maxPitch

    property bool ready: true
    property bool online: true
    property bool pitchInverted: true
    property bool rollInverted: false

    property real markFactor: 0.7

    property real effectiveHeight: height
    readonly property real sideHeight: Math.sqrt(Math.pow(height, 2) - Math.pow(width, 2))

    property alias markWidth: mark.markWidth
    property alias zigzag: mark.zigzag

    Behavior on pitch { PropertyAnimation { duration: 100 } }
    Behavior on roll { PropertyAnimation { duration: 100 } }

    clip: true
    implicitHeight: width

    Horizon {
        id: horizon
        anchors.centerIn: parent
        width: parent.height
        height: width
        visible: false
        effectiveHeight: ai.effectiveHeight
        online: ai.online
        pitch: pitchInverted && !isNaN(ai.pitch) ? ai.pitch : 0
        roll: !rollInverted && !isNaN(ai.roll) ? ai.roll : 0
        minPitch: ai.minPitch
        maxPitch: ai.maxPitch
    }

    Rectangle {
        id: mask
        anchors.fill: horizon
        anchors.margins: 1
        radius: width / 2
    }

    OpacityMask {
        anchors.fill: horizon
        source: horizon
        maskSource: mask
    }

    PlaneMark {
        id: mark
        anchors.centerIn: parent
        width: parent.width * markFactor
        effectiveHeight: ai.effectiveHeight
        pitch: pitchInverted ? 0 : -ai.pitch
        roll: rollInverted ? -ai.roll : 0
        markColor: ready ? Theme.aiMarkColor : Theme.extremeRed
        markWidth: 3
        z: 10
    }
}
