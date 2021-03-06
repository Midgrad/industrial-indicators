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

    property bool emergency: false
    property bool analyzeEnabled: false
    property bool outOfRangeIndication: true
    property color outOfRangeColor: Theme.extremeRed

    property int arrowRotationUp: 0
    property int arrowRotationDown: 0

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
            if (outOfRangeIndication) {
                colorUp = outOfRangeColor;
                arrowRotationUp = 90;
            }
            return;
        }

        if (valueUp > modelUp[modelUp.length - 1].value) {
            activeModelNumUp = 0;
            _persentUp = 100;
            colorUp = modelUp[modelUp.length - 1].color;
            if (outOfRangeIndication) {
                colorUp = outOfRangeColor
                arrowRotationUp = -90;
            }
            return;
        }

        _persentUp = 0;
        arrowRotationUp = 0;

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
            if (outOfRangeIndication) {
                colorDown = outOfRangeColor;
                arrowRotationDown = -90;
            }
            return;
        }

        if (valueDown > modelDown[modelDown.length - 1].value) {
            activeModelNumDown = 0;
            _persentDown = 100;
            colorDown = modelDown[modelDown.length - 1].color;
            if (outOfRangeIndication) {
                colorDown = outOfRangeColor;
                arrowRotationDown = 90;
            }
            return;
        }

        _persentDown = 0;
        arrowRotationDown = 0;

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

    function calculateScaleColor(index, modelDataColor) {
        if (root.enabled) {
            if (index === 0)
                return "transparent";
            else
                return modelDataColor;
        }
        return Theme.disabledColor;
    }

    function calculateScaleOpacity(index, activeModelNum) {
        if (!root.enabled || ((index !== 0 && index === activeModelNum) && analyzeEnabled))
            return 1;
        else
            return 0.2;
    }

    function calculateStateColor(scaleColor) {
        if (root.emergency && root.enabled)
            return Theme.extremeRed;
        if (!root.enabled)
            return Theme.disabledColor;
        if (!root.analyzeEnabled)
            return Theme.textColor;
        return scaleColor;
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing
        anchors.bottomMargin: Theme.margins / 8

        Repeater {
            id: repeaterUp
            model: [
                {value: 0},
                { percentage: 10, value: 10, color: Theme.severeOrange },
                { percentage: 20, value: 30, color: Theme.moderateYellow },
                { percentage: 40, value: 70, color: Theme.normalGreen },
                { percentage: 20, value: 90, color: Theme.moderateYellow },
                { percentage: 10, value: 100, color: Theme.severeOrange }
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
                    color: calculateScaleColor(index, modelData.color)
                    opacity: calculateScaleOpacity(index, root.activeModelNumUp)
                }
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing
        anchors.topMargin: Theme.margins / 8

        Repeater {
            id: repeaterDown
            model: [
                {value: 0},
                { percentage: 10, value: 10, color: Theme.severeOrange },
                { percentage: 20, value: 30, color: Theme.moderateYellow },
                { percentage: 40, value: 70, color: Theme.normalGreen },
                { percentage: 20, value: 90, color: Theme.moderateYellow },
                { percentage: 10, value: 100, color: Theme.severeOrange }
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
                    color: calculateScaleColor(index, modelData.color)
                    opacity: calculateScaleOpacity(index, root.activeModelNumDown)
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
        rotation: root.arrowRotationUp

        IconIndicator {
            implicitWidth: Theme.baseSize
            implicitHeight: Theme.baseSize
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: calculateStateColor(colorUp)
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
        rotation: root.arrowRotationDown + 180

        IconIndicator {
            implicitWidth: Theme.baseSize
            implicitHeight: Theme.baseSize
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: calculateStateColor(colorDown)
        }
    }
}

