import QtQuick 2.6
import QtQuick.Controls 2.2 as T
import Industrial.Indicators 1.0

T.ToolTip {
    id: control

    contentItem: Text {
        text: control.text
        font: control.font
        color: Theme.tipTextColor
        horizontalAlignment: Qt.AlignHCenter
    }

    background: Rectangle {
        color: Theme.tipColor
        radius: 3

        MouseArea {
            anchors.fill: parent
            onPressed: control.close()
        }
    }
}
