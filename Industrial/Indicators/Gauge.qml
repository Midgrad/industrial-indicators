import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0

// TODO: Base on Scale

Item {
    id: root

    property real value: 0.0
    property real _persent: 0
    property int rounding: 3
    property int spacing: 1
    property color color: Theme.textColor

    property int activeModelNum: 0

    property alias model: repeater.model

    implicitWidth: Theme.baseSize * 4
    implicitHeight: Theme.baseSize * 0.5

    onModelChanged: recalculate()
    onValueChanged: recalculate()

    function recalculate() {
        if (!model || model.length < 2)
        {
            tick.visible = false
            activeModelNum = 0;
            _persent = 0;
            color = Theme.disabledColor;
            return;
        } else {
            tick.visible = true
        }

        if (value < model[0].value)
        {
            activeModelNum = 0;
            _persent = 0;
            color = model[1].color;
            return;
        }

        if (value > model[model.length - 1].value)
        {
            activeModelNum = 0;
            _persent = 100;
            color = model[model.length - 1].color;
            return;
        }

        _persent = 0;

        for (var i = 1; i < model.length; ++i) {
            if (value > model[i].value) {
                _persent += model[i].percentage;
            }
            else {
                color = model[i].color;
                activeModelNum = i;
                _persent += Math.abs(model[i].percentage *
                                    (value - model[i - 1].value) / (model[i].value - model[i - 1].value));
                break;
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing

        Repeater {
            id: repeater
            model: [
                {value: 0},
                { percentage: 10, value: 10, color: Theme.extremeRed },
                { percentage: 20, value: 30, color: Theme.moderateYellow },
                { percentage: 40, value: 70, color: Theme.normalGreen },
                { percentage: 20, value: 90, color: Theme.moderateYellow },
                { percentage: 10, value: 100, color: Theme.extremeRed }
            ]

            Item {
                anchors.bottom: parent.bottom
                width: root.width * modelData.percentage / 100
                height: parent.height / 4
                clip: true

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: index == 1 ? 0 : -radius
                    anchors.rightMargin: index == repeater.count - 1 ? 0 : -radius
                    radius: root.rounding
                    color: (index != 0 && index == root.activeModelNum) ? modelData.color : "transparent"
                    border.width: 1
                    border.color: index == 0 ? "transparent" : modelData.color
                }
            }
        }
    }

    IconIndicator {
        visible: activeModelNum != 0
        id: tick
        x: _persent / 100 * root.width - width / 2
        anchors.verticalCenter: parent.verticalCenter
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
            color: root.color
        }
    }
}
