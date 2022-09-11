import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects
import android_test_application
import "../forms"
import "../mediaplayer"

Page {
    id: _streamingPage
    property StackView _currentStack
    property url _thumbnailUrl
    header: NavBar{
        id: _navBar
        _leftIcon: Assets.icons.arrowBack
        _pageTitle: _itemDelegate._title
        Connections{
            target: _navBar
            function onPopBack(){
                _currentStack.pop()
            }
        }
    }
    Loading{
        id: _streamingPageLoading
        visible: false
    }
    ColumnLayout{
        id: _col9
        anchors.fill: parent
        MainVideoPlayer{
            Layout.fillWidth: true
            Layout.preferredHeight: 300
        }
        StreamingPageDetails{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
