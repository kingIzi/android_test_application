import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application

Item{
    Connections{
        target: _user
        function onNewVideo(video){
            if (video.watchedUsers){
                _itemDelegate._watchedUsers = video.watchedUsers
            }
            if (video.likes){
                _itemDelegate._likes = video.likes
            }
            if (video.comments){
                _commentsForm._commentsModel.setAllComments(video.comments)
            }
            _streamingPageLoading.visible = false
        }
    }
    ScrollView{
        id: _scroll2
        anchors.fill: parent
        clip: true
        Flickable{
            id: _flick2
            contentHeight: _col10.implicitHeight
            ColumnLayout{
                id: _col10
                anchors.fill: parent
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _row5.implicitHeight
                    RowLayout{
                        id: _row5
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        Flow{
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            flow: Flow.TopToBottom
                            Label{
                                text: _itemDelegate._title
                                font: Typography.black.h6
                            }
                            Label{
                                text: _itemDelegate._released
                                color: "grey"
                                font: Typography.black.p
                            }
                        }
                        Label{
                            id: _watchedLbl
                            text: _itemDelegate._watchedUsers.length + " batala"
                            color: "grey"
                            font: Typography.black.p
                            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _row1.implicitHeight
                    Layout.alignment: Qt.AlignHCenter
                    RowLayout{
                        id: _row1
                        anchors.fill: parent
                        spacing: 8
                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: _col11.implicitHeight
                            ColumnLayout{
                                id: _col11
                                anchors.fill: parent
                                readonly property bool isLiked: _itemDelegate._likes.includes(_user.getLocalId())
                                RoundButton{
                                    id: _likeBtn
                                    Layout.alignment: Qt.AlignHCenter
                                    icon.source: Assets.icons.home
                                    icon.color: (_col11.isLiked) ? Colors.danger.main : Colors.neutral.neutral100
                                    Material.background: Colors.neutral.neutral0
                                    font: Typography.black.p
                                    onClicked: {
                                        _streamingPageLoading.visible = true
                                        _user.likeVideo(_itemDelegate._identifier)
                                    }
                                }
                                Label{
                                    text: "O lingi"
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: "AlignHCenter"
                                    font: Typography.black.p
                                }
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: _col12.implicitHeight
                            ColumnLayout{
                                id: _col12
                                anchors.fill: parent
                                readonly property bool isFavorite: _itemDelegate._favorites.includes(_itemDelegate._identifier)
                                RoundButton{
                                    id: _savedVideo
                                    Layout.alignment: Qt.AlignHCenter
                                    icon.source: Assets.icons.home
                                    icon.color: (_col12.isFavorite) ? Colors.danger.main : Colors.neutral.neutral100
                                    Material.background: Colors.neutral.neutral0
                                    font: Typography.black.p
                                    onClicked: {
                                        _streamingPageLoading.visible = true
                                        _user.saveVideo(_itemDelegate._identifier)
                                    }
                                }
                                Label{
                                    text: "Batela oyo"
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: "AlignHCenter"
                                    font: Typography.black.p
                                }
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: _col13.implicitHeight
                            ColumnLayout{
                                id: _col13
                                anchors.fill: parent
                                RoundButton{
                                    Layout.alignment: Qt.AlignHCenter
                                    icon.source: Assets.icons.home
                                    icon.color: Colors.neutral.neutral100
                                    Material.background: Colors.neutral.neutral0
                                    font: Typography.black.p
                                }
                                Label{
                                    text: "Kabela moninga"
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: "AlignHCenter"
                                    font: Typography.black.p
                                }
                            }
                        }
                    }
                }
                ToolSeparator{
                    orientation: "Horizontal"
                    Layout.fillWidth: true
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col14.implicitHeight
                    ColumnLayout{
                        id: _col14
                        anchors.fill: parent
                        Label{
                            text: "Ba commentaires"
                            padding: 8
                            Layout.fillWidth: true
                            font: Typography.black.h6
                        }
                        TextArea{
                            id: _commentTextArea
                            Layout.fillWidth: true
                            Layout.minimumHeight: 80
                            Layout.maximumHeight: 100
                            placeholderText: "Koma Commentaire awa"
                            font: Typography.black.p
                            padding: 8
                            wrapMode: "WordWrap"
                        }
                        Button{
                            font: Typography.bold.h6
                            text: "Commenter"
                            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                            Material.background: Colors.primary.main
                            Material.foreground: Colors.neutral.neutral10
                            onClicked: {
                                if (_commentTextArea.text.length > 0){
                                    _streamingPageLoading.visible = true
                                    _user.postVideoComment(_itemDelegate._identifier,_commentTextArea.text)
                                }
                            }
                        }
                    }
                }
                CommentsForm{
                    id: _commentsForm
                }
//                Item{
//                    Layout.fillWidth: true
//                    Layout.preferredHeight: _col15.implicitHeight
//                    StackView{
//                        id: _commentStack
//                        anchors.fill: parent
//                        initialItem: ColumnLayout{
//                            id: _col15
//                            Repeater{
//                                model: [
//                                    { text: "Some of the widgets available in Felgo AppSDK",
//                                        detailText: "scott.izidore@gmail.com"
//                                    },
//                                    { text: "ListPage, NavigationBar with different items, Switch",
//                                        detailText: "kapampaizi@gmail.com",
//                                    },
//                                    { text: "Some of the widgets available in Felgo AppSDK",
//                                        detailText: "scott.izidore@gmail.com",
//                                    },
//                                    { text: "ListPage, NavigationBar with different items, Switch",
//                                        detailText: "kapampaizi@gmail.com",
//                                    }
//                                ]
//                                delegate: ItemDelegate{
//                                    id: _commentDelegate
//                                    Layout.fillWidth: true
//                                    Layout.minimumHeight: 80
//                                    Layout.maximumHeight: 100
//                                    RowLayout{
//                                        id: _row7
//                                        anchors.fill: parent
//                                        RoundButton{
//                                            icon.source: Assets.images.africanWoman
//                                            Layout.alignment: Qt.AlignLeft
//                                        }
//                                        Label{
//                                            font: Typography.black.p
//                                            text: modelData.text
//                                            Layout.fillWidth: true
//                                            wrapMode: "WordWrap"
//                                            maximumLineCount: 4
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
            }
        }
    }
}
