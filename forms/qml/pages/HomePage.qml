import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application
import VideosList 1.0
import "../forms"

StackView{
    id: _homeStack
    initialItem: Page {
        id: _homePage
        header: NavBar{
            id: _navBar
            _pageTitle: "Home"
        }
        Loading{
            id: _homeLoading
            visible: true
        }
        Connections{
            target: _user
            function onAllVideos(videosDataList){
                _homeLoading.visible = false
                _homeVideosListModel.setVideosDataList(videosDataList)
            }
        }
        Item{
            anchors.fill: parent
            GridView{
                id: _videosGrid
                cellWidth: _root.width <= 640 ? _videosGrid.width : _videosGrid.width / 2
                cellHeight: 375
                anchors.fill: parent
                model: VideosListModel{
                    id: _homeVideosListModel
                }
                delegate: VideoDelegate{
                    id: _video1
                    _stack: _homeStack
                    width: _videosGrid.cellWidth
                    height: _videosGrid.cellHeight
                    _identifier: model.id
                    _title: model.title
                    _released: model.released.toLocaleDateString(Locale.ShortFormat)
                    _watchedUsers: model.watchedUsers
                    _likes: model.likes
                    _video: model.videoUrl
                    //_thumbnail: model.thumbnailUrl
                    _thumbnail: "https://www.nsbpictures.com/wp-content/uploads/2021/01/background-for-thumbnail-youtube-11.jpg"
                    Connections{
                        target: _video1
                        function onWatchVideo(nowStreaming){
                            _homeStack.push(nowStreaming)
                        }
                    }
                }
            }
        }
    }
}

