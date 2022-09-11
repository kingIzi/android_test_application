import QtQuick
import QtQuick.Controls.Material
import android_test_application
import "./forms"


ApplicationWindow {
    id: _root
    width: 411
    height: 823
    minimumWidth: 411
    minimumHeight: 480
    visible: true
    title: qsTr("Hello World")
    readonly property alias _navDrawer: _drawer
    NavBarDrawer{
        id: _drawer
    }

    Loader{
        id: _appLoader
        anchors.fill: parent
        visible: true
        active: visible
        source: "pages/LandingPage.qml"
        state: "LandingPage"
        states: [
            State {
                name: "LandingPage"
                PropertyChanges {
                    target: _appLoader
                    source: "pages/LandingPage.qml"
                }
            },
            State {
                name: "HomePage"
                PropertyChanges {
                    target: _appLoader
                    source: "pages/HomePage.qml"
                }
            },
            State {
                name: "FavoritePage"
                PropertyChanges {
                    target: _appLoader
                    source: "pages/FavoritePage.qml"
                }
            },
            State {
                name: "ProfilePage"
                PropertyChanges {
                    target: _appLoader
                    source: "pages/ProfilePage.qml"
                }
            }
        ]
    }
}
