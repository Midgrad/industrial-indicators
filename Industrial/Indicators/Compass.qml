import QtQuick 2.6
import Industrial.Indicators 1.0
import Industrial.Controls 1.0 as Controls

OperationalItem {
    id: root

    property real heading: 0
    property real course: 0
    property bool courseEnabled: true

    property color courseColor: Theme.positiveColor
    property color headingColor: {
        if (!enabled) return Theme.backgroundColor;
        if (!operational) return Theme.dangerColor;
        return Theme.textColor;
    }

    property real fontSize: height * 0.07
    property real tickMinorSize: fontSize * 0.3
    property real tickMajorSize: fontSize * 0.5
    property real tickTextedSize: fontSize * 0.8
    property real textOffset: fontSize * 1.5
    property real tickTextedWeight: 2
    property real tickMajorWeight: 1
    property real tickMinorWeight: 1
    property real arrowSize: width * 0.08
    property real centerOffset: textOffset + tickTextedSize

    property url mark
    property int tickFactor: 5

    implicitHeight: width
    implicitWidth: height

    Item {
        id: compassScale
        anchors.fill: parent
        rotation: -heading

        Repeater {
            model: 360 / tickFactor

            CompassTick {
                anchors.fill: compassScale
                value: modelData * tickFactor
                major: value % 10 == 0
                texted: value % 30 == 0
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: textOffset + tickTextedSize
        rotation: heading - course

        Controls.ColoredIcon {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: arrowSize
            height: width
            source: "qrc:/icons/ind_compass_arrow.svg"
            color: courseColor
        }
    }

    Image {
        anchors.fill: parent
        source: mark
        anchors.margins: centerOffset
    }
}
