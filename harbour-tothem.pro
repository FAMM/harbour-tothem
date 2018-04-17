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

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

SOURCES +=

OTHER_FILES += qml/harbour-tothem.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-tothem.changes.in \
    rpm/harbour-tothem.spec \
    rpm/harbour-tothem.yaml \
    harbour-tothem.desktop \
    qml/components/TaskListItem.qml \
    qml/cover/coveractions.py \
    qml/backend/__init__.py  \
    qml/backend/app.py \
    qml/backend/tasks/task.py

ICONPATH = /usr/share/icons/hicolor

86.png.path = $${ICONPATH}/86x86/apps/
86.png.files += icons/86x86/harbour-tothem.png

108.png.path = $${ICONPATH}/108x108/apps/
108.png.files += icons/108x108/harbour-tothem.png

128.png.path = $${ICONPATH}/128x128/apps/
128.png.files += icons/128x128/harbour-tothem.png

256.png.path = $${ICONPATH}/256x256/apps/
256.png.files += icons/256x256/harbour-tothem.png

tothem.desktop.path = /usr/share/applications/
tothem.desktop.files = harbour-tothem.desktop

INSTALLS += 86.png 108.png 128.png 256.png \
            tothem.desktop

DISTFILES += \
    icons/108x108/harbour-tothem.png \
    icons/128x128/harbour-tothem.png \
    icons/256x256/harbour-tothem.png \
    icons/86x86/harbour-tothem.png
