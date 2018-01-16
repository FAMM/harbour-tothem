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
import "pages"

ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./backend'));
            addImportPath(Qt.resolvedUrl('./backend/tasks'));

//            setHandler('progress', function(ratio) {
//                dlprogress.value = ratio;
//            });
//            setHandler('finished', function(newvalue) {
//                page.downloading = false;
//                mainLabel.text = 'Color is ' + newvalue + '.';
//            });

            importModule('app', function (s) {
                console.log(s)
                addItems();
            });

        }
//        function startDownload() {
//            page.downloading = true;
//            dlprogress.value = 0.0;
//            call('datadownloader.downloader.download', function() {});
//        }

//        onError: {
//            // when an exception is raised, this error handler will be called
//            console.log('python error: ' + traceback);
//        }

//        onReceived: {
//            // asychronous messages from Python arrive here
//            // in Python, this can be accomplished via pyotherside.send()
//            console.log('got message from python: ' + data);
//        }

        function addItems() {
            var toAdd = [
                        {id: 0, description: "Foo", done: false},
                        {id: 1, description: "Foo", done: false},
                        {id: 2, description: "Foo", done: false},
                        {id: 3, description: "Foo", done: false},
                        {id: 4, description: "Foo", done: false},
                        {id: 5, description: "Foo", done: true},
                        {id: 6, description: "Foo", done: true},
                        {id: 7, description: "Foo", done: true},
                        {id: 8, description: "Foo", done: true}
                    ];

            for(var i=0; i < toAdd.length; i++) {
               var task = toAdd[i]
               python.call("app.add_task",[task["id"], task["description"], task["done"], 0, 0])
            }
        }
    }
}


