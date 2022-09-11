import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application
import VideosList 1.0
import "../forms"

StackView{
    id: _favoriteStack
    initialItem: Page{
        header: NavBar{
            id: _navBar
            _pageTitle: "Favorites"
        }
        Loading{
            id: _favoritePageLoading
            visible: _emptyLabel.visible ? false : true
        }
        Label{
            id: _emptyLabel
            anchors.centerIn: parent
            text: "Nanu okomisi elili moko te"
            font: Typography.black.h6
            Material.foreground: Colors.neutral.neutral100
            visible: false
        }
        Connections{
            target: _user
            function onFavoriteVideos(favorites){
                _favoritePageLoading.visible = false
                _favoritesVideosListModel.setVideosDataList(favorites)
            }
            function onStartLoading(){
                _favoritePageLoading.visible = true
            }
        }
        Item{
            anchors.fill: parent
            visible: !_emptyLabel.visible
            GridView{
                id: _videosGrid
                cellWidth: _root.width <= 640 ? _videosGrid.width : _videosGrid.width / 2
                cellHeight: 360
                anchors.fill: parent
                model: VideosListModel{
                    id: _favoritesVideosListModel
                }
                delegate: VideoDelegate{
                    id: _video1
                    _stack: _favoriteStack
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

