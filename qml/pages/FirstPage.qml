/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import QtQml 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import "../components"

Page {
    id: page
    property bool downloading: false
    property bool ready: false

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: page.height

        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                text: "Settings"
                //onClicked: pageStack.push(settingsPage)
            }

            MenuItem {
                text: "Add Task"
                onClicked: function() {
                    pageStack.push(Qt.resolvedUrl("TaskEditorDialog.qml"), {})
                }
            }

            MenuItem {
                text: "Read from file"
                onClicked: readFromFile()
            }

            MenuItem {
                text: "Save to file"
                onClicked: saveToFile()
            }
        }

        SilicaListView {
            id: listView

            anchors.fill: parent

            model: taskListModel

            header: PageHeader {
                id: header
                width: parent.width
                title: "ToThem"
            }

            delegate: ListItem {
                id: listItem

                menu: taskItemContextMenu

                TaskListItem {
                    id: taskListItem
                    anchors.leftMargin: Theme.paddingSmall
                    anchors.rightMargin: Theme.paddingSmall

                    tid: model.tid
                    tuuid: model.tuuid
                    description: model.description
                    done: model.done
                    due: model.due
                    created_at: model.created_at
                }

                onClicked: {
                    var props = {
                        task: taskListItem
                    }
                    pageStack.push(Qt.resolvedUrl("TaskEditorDialog.qml"), props)
                }

                Component {
                    id: taskItemContextMenu
                    ContextMenu {
                        MenuItem {
                            text: taskListItem.done ? "Active" : "Done"
                            onClicked: {
                               taskListItem.done = !taskListItem.done
                               updateTask(taskListItem)
                            }
                        }
                        MenuItem {
                            text: "Delete"
                            onClicked: { removeTask( taskListItem.tuuid ); }
                        }
                    }
                }
            }

        }
    }

    ListModel {
        id: taskListModel
    }

    Component.onCompleted:
    {
        python.setHandler('finished', function() {
            readFromFile();
        });

        python.setHandler('tasks_updated', function(){
            console.log("tasks_updated!!!");
            loadTasks();
        });

        python.setHandler('got_write_handle', function(){
            console.log("got_write_handle!!!");
        });

        python.setHandler('got_read_handle', function(){
            console.log("got_read_handle!!!");
        });
    }

    function loadTasks() {
        var tasks = python.call_sync('app.tasklist.get_tasks');
        taskListModel.clear()

        for(var i = 0; i < tasks.length; i++) {
            taskListModel.append({
                 "tid": tasks[i]["id"],
                 "tuuid": tasks[i]["uuid"],
                 "description": tasks[i]["description"],
                 "done": tasks[i]["done"],
                 "due": tasks[i]["due"],
                 "created_at": tasks[i]["created_at"]
            });
        };
    }
}
