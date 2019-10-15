import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real valueUp: 0.0
    property real valueDown: 0.0
    property real _persentUp: 0
    property real _persentDown: 0
    property int rounding: 3
    property int spacing: 1
    property color colorUp: Theme.textColor
    property color colorDown: Theme.textColor

    property int activeModelNumUp: 1
    property int activeModelNumDown: 1

    property alias modelUp: repeaterUp.model
    property alias modelDown: repeaterDown.model

    implicitWidth: Controls.Theme.baseSize * 4
    implicitHeight: Controls.Theme.baseSize * 0.75

    onModelUpChanged: recalculateUp()
    onValueUpChanged: recalculateUp()

    onModelDownChanged: recalculateDown()
    onValueDownChanged: recalculateDown()


    function recalculateUp() {
        if (!modelUp || modelUp.length < 2 ||
                valueUp < modelUp[0].value ||
                valueUp > modelUp[modelUp.length - 1].value)
        {
            activeModelNumUp = 0;
            _persentUp = 0;
            colorUp = Controls.Theme.colors.disabled;
            return;
        }

        _persentUp = 0;

        for (var i = 1; i < modelUp.length; ++i) {
            if (valueUp > modelUp[i].value) {
                _persentUp += modelUp[i].percentage;
            }
            else {
                colorUp = modelUp[i].color;
                activeModelNumUp = i;

                _persentUp += Math.abs(modelUp[i].percentage *
                                    (valueUp - modelUp[i - 1].value) / (modelUp[i].value - modelUp[i - 1].value));

                break;
            }
        }
    }


    function recalculateDown() {
        if (!modelDown || modelDown.length < 2 ||
                valueDown < modelDown[0].value ||
                valueDown > modelDown[modelDown.length - 1].value)
        {
            activeModelNumDown = 0;
            _persentDown = 0;
            colorDown = Controls.Theme.colors.disabled;
            return;
        }

        _persentDown = 0;

        for (var i = 1; i < modelDown.length; ++i) {
            if (valueDown > modelDown[i].value) {
                _persentDown += modelDown[i].percentage;
            }
            else {
                colorDown = modelDown[i].color;
                activeModelNumDown = i;

                _persentDown += Math.abs(modelDown[i].percentage *
                                    (valueDown - modelDown[i - 1].value) / (modelDown[i].value - modelDown[i - 1].value));

                break;
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing

        Repeater {
            id: repeaterUp
            model: [
                {value: 0},
                { percentage: 10, value: 10, color: Theme.dangerColor },
                { percentage: 20, value: 30, color: Theme.cautionColor },
                { percentage: 40, value: 70, color: Theme.positiveColor },
                { percentage: 20, value: 90, color: Theme.cautionColor },
                { percentage: 10, value: 100, color: Theme.dangerColor }
            ]

            Item {
                width: root.width * modelData.percentage / 100
                height: root.height / 3
                anchors.bottom: parent.verticalCenter
                clip: true

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: index == 1 ? 0 : -radius
                    anchors.rightMargin: index == repeaterUp.count - 1 ? 0 : -radius
                    radius: root.rounding
                    color: (index != 0 && index == root.activeModelNumUp) ? modelData.color : "transparent"
                    border.width: 1
                    border.color: index == 0 ? "transparent" : modelData.color
                }
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing

        Repeater {
            id: repeaterDown
            model: [
                {value: 0},
                { percentage: 10, value: 10, color: Theme.dangerColor },
                { percentage: 20, value: 30, color: Theme.cautionColor },
                { percentage: 40, value: 70, color: Theme.positiveColor },
                { percentage: 20, value: 90, color: Theme.cautionColor },
                { percentage: 10, value: 100, color: Theme.dangerColor }
            ]

            Item {
                width: root.width * modelData.percentage / 100
                height: root.height / 3
                anchors.top: parent.verticalCenter
                clip: true

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: index == 1 ? 0 : -radius
                    anchors.rightMargin: index == repeaterDown.count - 1 ? 0 : -radius
                    radius: root.rounding
                    color: (index != 0 && index == root.activeModelNumDown) ? modelData.color : "transparent"
                    border.width: 1
                    border.color: index == 0 ? "transparent" : modelData.color
                }
            }
        }
    }



    Controls.ColoredIcon {
        visible: activeModelNumUp != 0
        id: tickUp
        x: _persentUp / 100 * root.width - width / 2
        anchors.verticalCenter: parent.top
        height: root.height
        width: height
        source: "qrc:/icons/ind_gauge_arrow.svg"
        color: Theme.backgroundColor


        Controls.ColoredIcon {
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: root.colorUp
        }
    }


    Controls.ColoredIcon {
        id: tickDown
        x: _persentDown / 100 * root.width - width / 2
        anchors.verticalCenter: parent.bottom
        height: root.height
        width: height
        source: "qrc:/icons/ind_gauge_arrow.svg"
        color: Theme.backgroundColor
        rotation: 180

        Controls.ColoredIcon {
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: root.colorDown
        }
    }


}
