import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Dialog {
    property TaskListItem task: TaskListItem{ }

    Column {
        width: parent.width

        DialogHeader {
            id: taskEditorHeader
            title: task.tid ? "Edit task" : "Create task"
            acceptText: task.tid ? "Save" : "Create"
        }

        TextField {
            id: descriptionField
            width: parent.width
            labelVisible: true
            placeholderText: "What do you want to do?"
            label: "Description"
            text: task.description
        }

        ValueButton {
            function openDateDialog() {
                var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", {
                    date: task.due.getTime() ? task.due : new Date()
                })

                dialog.accepted.connect(function() {
                    value= dialog.dateText
                    task.due = dialog.date
                })
            }

            label: "Due"
            value: task.due.getTime() ? task.due.toDateString() : "Select"
            width: parent.width
            onClicked: openDateDialog()
        }

        DetailItem{
            label: "ID"
            value: task.tid
            visible: task.tid
        }

        DetailItem {
            label: "UUID"
            value: task.tuuid
            visible: task.tuuid
        }

        DetailItem {
            label: "Created At"
            value: task.created_at.toLocaleString()
            visible: task.created_at.getTime()
        }
    }

    onDone: function() {
        if (result == DialogResult.Accepted) {
            task.description = descriptionField.text
            if (task.tuuid) {
                updateTask( task );
            } else {
                addTask( task )
            }
        }
    }
}
