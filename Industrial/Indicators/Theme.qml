pragma Singleton
import QtQuick 2.6

QtObject {
    id: root

    property int baseSize: 16
    property int fontSize: 14
    property int auxFontSize: fontSize * 0.8
    property int margins: 8
    property int padding: 4

    property color textColor: "#ffffff"
    property color backgroundColor: "#1a2226"
    property color disabledColor: "#bbc1c4"
    property color activeColor: "#fd00fd"

    property color extremeRed: "#ce2029"
    property color severeOrange: "#ff4f00"
    property color moderateYellow: "#eed202"
    property color normalGreen: "#01b36d"
    property color stanbyColor: "#3c77d6"

    property color skyHighColor: "#0d1bd9"
    property color skyLowColor: "#00d4ff"
    property color groundHighColor: "#95833b"
    property color groundLowColor: "#68342b"

    property color skyOffHighColor: "#364354"
    property color skyOffLowColor: "#e0f1f8"
    property color groundOffHighColor: "#9ea79b"
    property color groundOffLowColor: "#30342e"

    property color missionColor: "#1ce9a5"

    // air indicator
    property color aiTextColor: "#ffffff"
    property color aiMarkColor: "#1a2226"

    property color tipColor: "#009688"
    property color tipTextColor: "#ffffff"
}
