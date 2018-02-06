import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string description
    property string id
    property date due

    Column {
        width: parent.width

        DialogHeader {
            acceptText: id === null ? "Create" : "Save"
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
                console.log(due.getTime() ? "foo":"bar")

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
    }

    onDone: {
        if (result == DialogResult.Accepted) {
            description = descriptionField.text
            console.log(description)
        }
    }
}
