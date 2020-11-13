import QtQuick 2.6
import Industrial.Indicators 1.0

Item {
    id: root

    property real roll: 0.0
    property real minRoll: -25.0
    property real maxRoll: 25.0
    property real rollStep: 5.0
    property int digits: 0

    property real arrowSize: Theme.fontSize
    property real tickSize: Theme.fontSize * 0.4
    property real tickWeight: 1
    property real fontSize: Math.max(height * 0.1, 8)

    property color color: Theme.textColor
    property bool visibleText: false

    function mapToRange(pitch) {
        return Helper.mapToRange(pitch, minPitch, maxPitch, height);
    }

    Repeater {
        id: repeater
        model: {
            var rolls = [];
            for (var roll = minRoll - (minRoll % rollStep); roll <= maxRoll;
                 roll += rollStep) {
                rolls.push(roll);
            }
            return rolls;
        }

        RollScaleTick {
            anchors.fill: parent
            rotation: modelData
            color: root.color
            opacity: (90 - Math.abs(rotation)) / 90
        }
    }

    Item {
        anchors.fill: parent
        rotation: Math.max(Math.min(-roll, maxRoll), minRoll)

        IconIndicator {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: arrowSize
            height: width
            source: "qrc:/icons/ind_heading_arrow.svg"
            color: root.color
        }

        Text {
            anchors.top: parent.top
            anchors.topMargin: arrowSize
            anchors.horizontalCenter: parent.horizontalCenter
            text: digits > 0 ? value.toFixed(digits) : Math.floor(roll)
            font.pixelSize: fontSize
            color: root.color
            visible: visibleText
        }
    }
}
