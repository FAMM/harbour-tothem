import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: self
    property bool enabled
    property string label

    width: parent.width
    anchors.fill: parent

    Image {
        id: icon
        source: parent.enabled ? "image://theme/icon-m-tabs" : 'image://theme/icon-m-certificates'
    }

    Label {
        id: labelElem
        text: parent.label
        anchors.left: icon.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.verticalCenter: icon.verticalCenter
    }
}
