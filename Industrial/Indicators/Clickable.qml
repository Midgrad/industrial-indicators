import QtQuick 2.6
import QtQuick.Templates 2.2 as T
import Industrial.Indicators 1.0


Item {
    id: control

    implicitWidth: icon.implicitWidth + Theme.padding
    implicitHeight: icon.implicitWidth + Theme.padding

    property alias iconSource: icon.source
    property alias iconColor: icon.color
    property alias iconSize: icon.width
    property alias contentWidth: icon.width

    signal clicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        //acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: control.clicked()
    }

    IconIndicator {
        id: icon
        implicitWidth: Theme.baseSize
        implicitHeight: Theme.baseSize
        height: parent.height
        width: height
        anchors.fill: parent
        anchors.margins: Theme.padding
    }
}



