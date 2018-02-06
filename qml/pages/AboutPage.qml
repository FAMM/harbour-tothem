import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    SilicaFlickable {
        anchors.fill: parent
        contentWidth: parent.width

        VerticalScrollDecorator {}

        Column{
            spacing: Theme.paddingMedium
            width: parent.width

            PageHeader {
                id: header
                width: parent.width
                title: "About"
            }

            Label {
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                width: aboutPage.width - 2*Theme.horizontalPageMargin
            }

            SectionHeader {
                   text: "Authors"
            }

            DetailItem {
                label: "Alexander Kratzsch"
                value: "Cloud Deployment and rants"
            }

            DetailItem {
                label: "Franz 'Otto' Kuntke"
                value: "Frontend Dev"
            }

            DetailItem {
                label: "Max Kießling"
                value: "Der Rest"
            }

            SectionHeader {
               text: "Contributing"
            }

            LinkedLabel {
                wrapMode: Text.Wrap
                anchors.horizontalCenter: parent.horizontalCenter
                width: aboutPage.width - 2*Theme.horizontalPageMargin
                plainText: "Find the code on: https://github.com/FAMM/harbour-tothem"
            }

            LinkedLabel {
                wrapMode: Text.Wrap
                anchors.horizontalCenter: parent.horizontalCenter
                width: aboutPage.width - 2*Theme.horizontalPageMargin
                plainText: "Distributed under MIT License https://choosealicense.com/licenses/mit/"
            }
        }
    }
}
