import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string tid
    property string tuuid
    property string description
    property bool tdone: false
    property date due

    Column {
        width: parent.width

        DialogHeader {
            acceptText: tid ? "Save" : "Create"
        }

        TextField {
            id: descriptionField
            width: parent.width
            labelVisible: true
            placeholderText: "What do you want to do?"
            label: "Description"
            text: description
        }

        ValueButton {
            function openDateDialog() {
                var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", {
                    date: due.getTime() ? due : new Date()
                })

                dialog.accepted.connect(function() {
                    value= dialog.dateText
                    due = dialog.date
                })
            }

            label: "Due"
            value: due.getTime() ? due.toDateString() : "Select"
            width: parent.width
            onClicked: openDateDialog()
        }

        DetailItem{
            label: "ID"
            value: tid
            visible: tid
        }

        DetailItem {
            label: "UUID"
            value: tuuid
            visible: tuuid
        }
    }

    onDone: function() {
        if (result == DialogResult.Accepted) {
            description = descriptionField.text
            if (tuuid) {
                python.call_sync("app.tasklist.update_task", [tuuid, description, tdone, due, ""]);
            } else {
                python.call_sync("app.tasklist.add_task", [description, tdone, due, ""]);
            }
        }
    }
}
