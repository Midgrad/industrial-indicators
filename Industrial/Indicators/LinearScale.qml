import QtQuick 2.6
import Industrial.Indicators 1.0

Scale {
    id: root

    property real minValue: 0
    property real maxValue: 100
    property real valueStep: 10
    property real minValueImpl: minValue
    property real valueStepImpl: valueStep
    property real dValue: -1

    mapToRange: function (val) {
        return Helper.mapToRange(val, minValue, maxValue, root.height);
    }

    mapFromRange: function (pos) {
        return Helper.mapFromRange(pos, minValue, maxValue, root.height);
    }

    model: {
        var vals = [];

        if (minValueImpl < maxValue && valueStepImpl > 0) {
            var index = -1;
            for (var tickValue = minValueImpl; tickValue <= maxValue; tickValue += valueStepImpl) {

                index++;
                if (Math.abs(tickValue - value) < dValue)
                    continue;

                let item = {
                    value: tickValue,
                    major: index % 2 == 0
                }

                vals.push(item);
            }
        }
        return vals;
    }
}
