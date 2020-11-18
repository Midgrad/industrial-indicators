import QtQuick 2.6
import Industrial.Indicators 1.0

OperationalItem {
    id: root

    property string tipText
    property real heading: 0
    property real course: 0
    property bool courseEnabled: true
    readonly property real safeHeading: isNaN(heading) ? 0 : heading

    property color iconColor: Theme.textColor
    property color courseColor: Theme.normalGreen
    property color headingColor: {
        if (!enabled) return Theme.disabledColor;
        if (!operational) return Theme.extremeRed;
        return Theme.textColor;
    }

    property real fontSize: height * 0.1
    property real tickMinorSize: fontSize * 0.2
    property real tickMajorSize: fontSize * 0.4
    property real tickTextedSize: fontSize * 0.5
    property real textOffset: fontSize * 1.4
    property real tickTextedWeight: 2
    property real tickMajorWeight: 1
    property real tickMinorWeight: 1
    property real arrowSize: width * 0.15
    property real centerOffset: textOffset + tickTextedSize

    property url mark
    property int tickFactor: 5

    implicitHeight: width
    implicitWidth: height

    Item {
        id: compassScale
        anchors.fill: parent
        rotation: -safeHeading

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
        rotation: -safeHeading + course

        IconIndicator {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: arrowSize
            height: width / 2
            source: "qrc:/icons/ind_course_arrow.svg"
            color: courseColor
        }
    }

    IconIndicator {
        color: iconColor
        anchors.fill: parent
        source: mark
        anchors.margins: root.width * 0.2
    }

    MouseArea {
        id: compassMouseArea
        anchors.fill: parent
        hoverEnabled: true
        z: 10
    }

    ToolTip {
        visible: compassMouseArea.containsMouse && tipText.length
        text: tipText
    }
}
