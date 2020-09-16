import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.Label {
    id: control

    font.pixelSize: Theme.fontSize
    color: control.enabled ? Theme.textColor : Theme.disabledColor
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}
