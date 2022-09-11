import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import CommentsList 1.0
import android_test_application

Item{
    Layout.fillWidth: true
    Layout.preferredHeight: _col15.implicitHeight
    readonly property alias _commentsModel: _commentsListModel
    StackView{
        id: _commentStack
        anchors.fill: parent
        initialItem: ColumnLayout{
            id: _col15
            Repeater{
//                model: [
//                    { text: "Some of the widgets available in Felgo AppSDK",
//                        detailText: "scott.izidore@gmail.com"
//                    },
//                    { text: "ListPage, NavigationBar with different items, Switch",
//                        detailText: "kapampaizi@gmail.com",
//                    },
//                    { text: "Some of the widgets available in Felgo AppSDK",
//                        detailText: "scott.izidore@gmail.com",
//                    },
//                    { text: "ListPage, NavigationBar with different items, Switch",
//                        detailText: "kapampaizi@gmail.com",
//                    }
//                ]
                model: CommentsListModel{
                    id: _commentsListModel
                }

                delegate: ItemDelegate{
                    id: _commentDelegate
                    Layout.fillWidth: true
                    Layout.minimumHeight: 80
                    Layout.maximumHeight: 100
                    property bool _isLiked: false
                    property string _comment: model.comment
                    property string _email: model.email
                    property string _published: model.published
                    on_IsLikedChanged: {
                        console.log("like comment",_commentDelegate._isLiked)
                    }
                    RowLayout{
                        id: _row7
                        anchors.fill: parent
                        RoundButton{
                            icon.source: Assets.images.africanWoman
                            Layout.alignment: Qt.AlignLeft
                            Material.background: "transparent"
                        }
                        Label{
                            font: Typography.black.p
                            text: _commentDelegate._comment
                            Layout.fillWidth: true
                            wrapMode: "WordWrap"
                            maximumLineCount: 4
                        }
//                        RoundButton{
//                            icon.source: Assets.icons.favorite
//                            icon.color: _commentDelegate._isLiked ? "red" : "black"
//                            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
//                            Material.background: "transparent"
//                            onClicked: {
//                                if (_commentDelegate._isLiked){
//                                    _commentDelegate._isLiked = false
//                                }
//                                else{
//                                    _commentDelegate._isLiked = true
//                                }
//                            }
//                        }
                    }
                }
            }
        }
    }
}
