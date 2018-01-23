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
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import "../components"

Page {

    id: page
    property bool downloading: false


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

            onClicked: {
                var props = {
                    label: title,
                    enabled: active
                }

                pageStack.push(Qt.resolvedUrl("TaskPage.qml"), props)
            }

            TaskListItem {
                anchors.leftMargin: Theme.paddingSmall
                anchors.rightMargin: Theme.paddingSmall
                id: taskListItem
                enabled: active
                label: title
            }

            Component {
                id: taskItemContextMenu
                ContextMenu {
                    MenuItem {
                        text: taskListItem.enabled ? "Done" : "Activate"
                        onClicked: { taskListItem.enabled = !taskListItem.enabled }
                    }
                    MenuItem {
                        text: "Delete"
                        onClicked: {}
                    }
                }
            }

        }

    }

    ListModel {
        id: taskListModel
    }

    onPageContainerChanged: loadTasks()

    function appendStuff(tasks) {
        console.log("Huhu!! in appendStuff");
    }

    function loadTasks() {
        var tasks = python.call_sync('app.tasklist.get_tasks');

        console.log(tasks);

        for(var i = 0; i < 1; i++) {
//            var t = tasks[0];
            console.log("Huhu!!");
            console.log(tasks[0]["id"]);
            console.log(tasks[0]["description"]);
            //console.log(true); <- heavily forbidden (?)
            taskListModel.append({
                 "id": tasks[0]["id"],
                 "title": tasks[0]["description"],
                 "active": false
            });
        };

        console.log("Huhu!! in loadTasks");
    }
}


