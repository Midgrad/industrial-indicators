import QtQuick 2.6
import QtQuick.Templates 2.2 as T
import Industrial.Indicators 1.0

T.Button { // TODO: clickable
    id: control

    property bool round: false
    property bool pressedImpl: false
    property bool topCropped: false
    property bool bottomCropped: false
    property bool leftCropped: false
    property bool rightCropped: false
    property bool hatched: !enabled && !flat
    property color color:  "transparent"
    property string tipText

    property alias iconSource: icon.source
    property alias iconColor: icon.color
    property alias iconSize: icon.width
    property alias contentWidth: icon.width

    implicitWidth: Math.max(implicitHeight, icon.implicitWidth + control.padding * 2)
    implicitHeight: Theme.baseSize
    focusPolicy: Qt.NoFocus
    hoverEnabled: true
    padding: Theme.padding
    font.pixelSize: Theme.mainFontSize



    contentItem: Image {
        id: icon
        anchors.fill: parent
        anchors.margins: control.padding
    }

}
