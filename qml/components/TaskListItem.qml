import QtQuick 2.0
import QtQml 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Item {
    id: taskListItem
    property int tid
    property string tuuid
    property string description
    property bool done : false
    property date due
    property date created_at

    Image {
        id: icon
        source: done ? 'image://theme/icon-m-certificates' : "image://theme/icon-m-tabs"
    }

    Label {
        id: labelElem
        text: description
        anchors.left: icon.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.verticalCenter: icon.verticalCenter
    }
}
