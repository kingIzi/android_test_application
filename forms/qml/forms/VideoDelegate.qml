import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application
import "../pages"


ItemDelegate{
    id: _itemDelegate
    width: parent.width
    height: 360
    signal watchVideo(var nowStreaming)
    property url _video: ""
    property string _identifier: ""
    property url _thumbnail: ""
    property string _title: ""
    property string _released: ""
    property var _watchedUsers: []
    property var _likes: []
    property var _favorites: _user.favorites
    property StackView _stack
    Component{
        id: _nowStreaming
        StreamingPage{
            id: _streamingPage
            _currentStack: _itemDelegate._stack
            _thumbnailUrl: _itemDelegate._thumbnail
        }
    }
    onClicked: {
        _user.addWatchedVideo(_itemDelegate._identifier)
        _itemDelegate.watchVideo(_nowStreaming)
    }
    ColumnLayout{
        id: _col3
        anchors.fill: parent
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: 280
            Image {
                id: _thumbnailImg
                source: _thumbnail
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
            }
        }
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Colors.primary.bgColor
            ColumnLayout{
                anchors.fill: parent
                anchors.margins: 10
                Label{
                    id: _titleLbl
                    text: _title
                    font: Typography.bold.h6
                    Layout.fillWidth: true
                    Material.foreground: Colors.neutral.neutral100
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    RowLayout{
                        anchors.fill: parent
                        Label{
                            text: _released
                            font: Typography.black.p
                            Material.foreground: Colors.neutral.neutral100
                            Layout.alignment: Qt.AlignLeft
                        }
                        Label{
                            text: _itemDelegate._watchedUsers.length + " batala"
                            font: Typography.black.p
                            Material.foreground: Colors.neutral.neutral100
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                }
            }
        }
    }
}
