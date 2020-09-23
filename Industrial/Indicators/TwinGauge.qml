import QtQuick 2.6
import Industrial.Indicators 1.0

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

    implicitWidth: Theme.baseSize * 4
    implicitHeight: Theme.baseSize * 1.5

    onModelUpChanged: recalculateUp()
    onValueUpChanged: recalculateUp()

    onModelDownChanged: recalculateDown()
    onValueDownChanged: recalculateDown()


    function recalculateUp() {
        if (!modelUp || modelUp.length < 2) {
            tickUp.visible = false
            colorUp = Theme.disabledColor;
            return;
        } else {
            tickUp.visible = true
        }

        if (valueUp < modelUp[0].value) {
            activeModelNumUp = 0;
            _persentUp = 0;
            colorUp = modelUp[1].color;
            return;
        }

        if (valueUp > modelUp[modelUp.length - 1].value) {
            activeModelNumUp = 0;
            _persentUp = 100;
            colorUp = modelUp[modelUp.length - 1].color;
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
        if (!modelDown || modelDown.length < 2) {
            tickDown.visible = false
            colorDown = Theme.disabledColor;
            return;
        } else {
            tickDown.visible = true
        }

        if (valueDown < modelDown[0].value) {
            activeModelNumDown = 0;
            _persentDown = 0;
            colorDown = modelDown[1].color;
            return;
        }

        if (valueDown > modelDown[modelDown.length - 1].value) {
            activeModelNumDown = 0;
            _persentDown = 100;
            colorDown = modelDown[modelDown.length - 1].color;
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
                { percentage: 10, value: 10, color: Theme.extremeRed },
                { percentage: 20, value: 30, color: Theme.moderateYellow },
                { percentage: 40, value: 70, color: Theme.normalGreen },
                { percentage: 20, value: 90, color: Theme.moderateYellow },
                { percentage: 10, value: 100, color: Theme.extremeRed }
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
                    color:  (index != 0 && index == root.activeModelNumUp) ? (root.enabled ? modelData.color : Theme.disabledColor)  : "transparent"
                    border.width: 1
                    border.color: root.enabled ? (index == 0 ? "transparent" : modelData.color) : Theme.disabledColor
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
                { percentage: 10, value: 10, color: Theme.extremeRed },
                { percentage: 20, value: 30, color: Theme.moderateYellow },
                { percentage: 40, value: 70, color: Theme.normalGreen },
                { percentage: 20, value: 90, color: Theme.moderateYellow },
                { percentage: 10, value: 100, color: Theme.extremeRed }
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
                    color: (index != 0 && index == root.activeModelNumDown) ? (root.enabled ? modelData.color : Theme.disabledColor) : "transparent"
                    border.width: 1
                    border.color: root.enabled ? (index == 0 ? "transparent" : modelData.color) : Theme.disabledColor
                }
            }
        }
    }

    IconIndicator {
        id: tickUp
        x: _persentUp / 100 * root.width - width / 2
        anchors.verticalCenter: parent.top
        height: parent.height
        width: height
        source: "qrc:/icons/ind_gauge_arrow.svg"
        color: Theme.backgroundColor


        IconIndicator {
            implicitWidth: Theme.baseSize
            implicitHeight: Theme.baseSize
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: root.enabled ? root.colorUp : Theme.disabledColor
        }
    }

    IconIndicator {
        id: tickDown
        x: _persentDown / 100 * root.width - width / 2
        anchors.verticalCenter: parent.bottom
        height: parent.height
        width: height
        source: "qrc:/icons/ind_gauge_arrow.svg"
        color: Theme.backgroundColor
        rotation: 180

        IconIndicator {
            implicitWidth: Theme.baseSize
            implicitHeight: Theme.baseSize
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: root.enabled ? root.colorDown : Theme.disabledColor
        }
    }
}

