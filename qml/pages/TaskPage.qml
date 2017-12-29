import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4
import "../components"

Page {
    id: taskPage

    property string label
    property bool enabled

    Label {
        text: label
    }
}


