import QtQuick 2.6
import Industrial.Indicators 1.0
import Industrial.Controls 1.0

ValueLabel {
    id: root

    property bool isLongitude: false

    valueText: isNaN(value) ? "-" : Helper.degreesToDmsString(value, isLongitude, digits)
}

