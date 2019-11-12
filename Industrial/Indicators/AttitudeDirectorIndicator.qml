import QtQuick 2.6
import Industrial.Indicators 1.0

AttitudeIndicator {
    id: fd

    property real desiredPitch: 0.0
    property real desiredRoll: 0.0

    property real pitchStep: 5
    property real maxRoll: width > height ? 90 : 90 - (180 * Math.acos(width / height) / Math.PI)
    property real minRoll: -maxRoll
    property real rollStep: 10

    property bool inputEnabled: false

    property alias desiredVisible: desiredMark.visible

    signal addPitch(real value)
    signal addRoll(real value)

    Behavior on desiredPitch { PropertyAnimation { duration: 100 } }
    Behavior on desiredRoll { PropertyAnimation { duration: 100 } }

    effectiveHeight: height - Theme.baseSize

    RollScale {
        id: rollScale
        anchors.fill: parent
        roll: rollInverted ? -fd.roll : fd.roll
        minRoll: fd.minRoll
        maxRoll: fd.maxRoll
        rollStep: fd.rollStep
        opacity: enabled ? 1 : 0.33
        color: operational ? Theme.textColor : Theme.dangerColor
    }

    PitchScale {
        id: pitchScale
        anchors.centerIn: parent
        width: parent.width
        height: effectiveHeight
        roll: rollInverted ? 0 : fd.roll
        minPitch: pitchInverted ? fd.pitch + fd.minPitch : fd.minPitch
        maxPitch: pitchInverted ? fd.pitch + fd.maxPitch : fd.maxPitch
        pitchStep: fd.pitchStep
        opacity: enabled ? 1 : 0.33
        color: operational ? Theme.aiTextColor : Theme.dangerColor
    }

    Text {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -height
        text: qsTr("DISARMED")
        font.pixelSize: fd.height * 0.1
        font.bold: true
        color: armed ? "transparent" : Theme.dangerColor
    }

    DesiredAnglesMark {
        id: desiredMark
        anchors.centerIn: parent
        width: parent.width * 0.7
        effectiveHeight: fd.effectiveHeight
        pitch: pitchInverted ? fd.pitch - desiredPitch : -desiredPitch
        roll: rollInverted ? -desiredRoll : fd.roll - desiredRoll
    }

    PlaneMark {
        id: mark
        anchors.centerIn: parent
        width: parent.width * 0.7
        effectiveHeight: fd.effectiveHeight
        pitch: pitchInverted ? 0 : -fd.pitch
        roll: rollInverted ? -fd.roll : 0
        markColor: armed ? Theme.aiMarkColor : Theme.dangerColor
        markWidth: 3
    }

    Clickable {
        anchors.top: pitchScale.top
        anchors.horizontalCenter: pitchScale.horizontalCenter
        iconSource: "qrc:/icons/ind_arrow_up.svg"
        iconColor: Theme.backgroundColor
        visible: inputEnabled
        onClicked: addPitch(-0.05)
    }

    Clickable {
        anchors.bottom: pitchScale.bottom
        anchors.horizontalCenter: pitchScale.horizontalCenter
        iconSource: "qrc:/icons/ind_arrow_down.svg"
        iconColor: Theme.backgroundColor
        visible: inputEnabled
        onClicked: addPitch(0.05)
    }

    Clickable {
        anchors.top: parent.top
        anchors.topMargin: (fd.height - fd.sideHeight) / 2
        anchors.left: parent.left
        iconSource: "qrc:/icons/ind_bank_left.svg"
        iconColor: Theme.backgroundColor
        visible: inputEnabled
        onClicked: addRoll(-0.05)
    }

    Clickable {
        anchors.top: parent.top
        anchors.topMargin: (fd.height - fd.sideHeight) / 2
        anchors.right: parent.right
        iconSource: "qrc:/icons/ind_bank_right.svg"
        iconColor: Theme.backgroundColor
        visible: inputEnabled
        onClicked: addRoll(0.05)
    }
}
