# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-tothem

CONFIG += sailfishapp_qml

SOURCES +=

OTHER_FILES += qml/harbour-tothem.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-tothem.changes.in \
    rpm/harbour-tothem.spec \
    rpm/harbour-tothem.yaml \
    harbour-tothem.desktop \
    qml/cover/coveractions.py \
    qml/backend/__init__.py  \
    qml/backend/app.py \
    qml/backend/tasks/task.py
