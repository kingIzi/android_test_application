import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.platform
import android_test_application
import "../forms"

Page {
    id: _profilePage
    header: NavBar{
        id: _navBar
        _pageTitle: "Profil"
    }
    Loading{
        id: _profilePageLoading
        visible: false
    }
    FileDialog{
        id: _imgDialog
        nameFilters: ["*.jpg","*.png","*.jpeg"]
    }
    Item{
        id: _item5
        anchors.fill: parent
        ColumnLayout{
            id: _col6
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                Layout.alignment: Qt.AlignTop
                Rectangle{
                    width: 150
                    height: 150
                    radius: 75
                    color: Colors.neutral.neutral60
                    anchors.horizontalCenter: parent.horizontalCenter
                    RoundButton{
                        anchors.centerIn: parent
                        icon.source: Assets.icons.home
                        icon.color: Colors.neutral.neutral10
                        Material.background: Colors.neutral.neutral0
                        onClicked: _imgDialog.open()
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _row4.implicitHeight
                RowLayout{
                    id: _row4
                    anchors.fill: parent
                    Label{
                        font: Typography.black.p
                        text: "Email"
                        color: Colors.neutral.neutral100
                    }
                    TextField{
                        id: _emailField
                        Layout.fillWidth: true
                        placeholderText: "Koma email awa"
                        font: Typography.black.p
                        Material.foreground: Colors.neutral.neutral100
                        text: _user.getEmail()
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _row7.implicitHeight
                RowLayout{
                    id: _row7
                    anchors.fill: parent
                    Label{
                        font: Typography.black.p
                        text: "Kombo na bino"
                        color: Colors.neutral.neutral100
                    }
                    TextField{
                        id: _nameField
                        Layout.fillWidth: true
                        placeholderText: "Koma kombo awa"
                        font: Typography.black.p
                        Material.foreground: Colors.neutral.neutral100
                        text: _user.getFullName()
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _row5.implicitHeight
                RowLayout{
                    id: _row5
                    anchors.fill: parent
                    Label{
                        font: Typography.black.p
                        text: "Tshombo"
                        color: Colors.neutral.neutral100
                    }
                    TextField{
                        id: _telephoneField
                        Layout.fillWidth: true
                        placeholderText: "Nimero ya tshombo awa"
                        font: Typography.black.p
                        Material.foreground: Colors.neutral.neutral100
                        text: _user.getTelephone()
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _row6.implicitHeight
                RowLayout{
                    id: _row6
                    anchors.fill: parent
                    Label{
                        font: Typography.black.p
                        text: "Address"
                        color: Colors.neutral.neutral100
                    }
                    TextField{
                        id: _addressField
                        Layout.fillWidth: true
                        placeholderText: "Address awa"
                        font: Typography.black.p
                        Material.foreground: Colors.neutral.neutral100
                        text: _user.getAddress()
                    }
                }
            }
            Button{
                id: _btn2
                Layout.alignment: Qt.AlignHCenter
                text: "Bongola"
                font: Typography.bold.h6
                Material.background: Colors.primary.main
                Material.foreground: Colors.neutral.neutral10
                Layout.fillWidth: true
                enabled: false
                Binding{
                    target: _btn2.background
                    property: "radius"
                    value: 20
                }
            }
        }
    }
}
