import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application
import "../scripts/constants.js" as JS


Item {
    id: _registerPage
    readonly property alias _emailError: _emailErrorLbl
    readonly property alias _passwordError: _passwordErrorLbl
    QtObject{
        id: _signUpData
        readonly property string fullName: _nameField.text
        readonly property string telephone: _telephoneField.text
        readonly property string address: _addressField.text
        readonly property string email: _emailField.text
        readonly property string password: _passwordField.text
    }
    ScrollView{
        anchors.fill: parent
        clip: true
        Flickable{
            contentHeight: _col2.implicitHeight
            ColumnLayout{
                id: _col2
                anchors.fill: parent
                spacing: 20
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col3.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col3
                        anchors.fill: parent
                        spacing: 4
                        Label{
                            Layout.fillWidth: true
                            font: Typography.bold.p
                            text: "Kombo na yo"
                        }
                        TextField{
                            id: _nameField
                            Layout.fillWidth: true
                            placeholderText: "koma kombo na yo"
                            font: Typography.black.p
                            rightPadding: 32
                            echoMode: "Normal"
                            Item{
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                visible: _nameField.text.length > 0
                                width: 28
                                height: 28
                                Image{
                                    source: Assets.icons.close
                                    fillMode: Image.PreserveAspectFit
                                    anchors.fill: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: _nameField.text = ""
                                }
                            }
                        }
                        Label{
                            Layout.fillWidth: true
                            font: Typography.black.p
                            text: ""
                            color: Colors.danger.main
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col4.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col4
                        anchors.fill: parent
                        spacing: 4
                        Label{
                            Layout.fillWidth: true
                            font: Typography.bold.p
                            text: "Nimero ya tshombo (soki olingi)"
                        }
                        TextField{
                            id: _telephoneField
                            Layout.fillWidth: true
                            placeholderText: "koma nimero ya tshombo"
                            font: Typography.black.p
                            rightPadding: 32
                            echoMode: "Normal"
                            validator: RegularExpressionValidator { regularExpression: /\d{1,11}(?:,\d{1,11})+$/ }
                            Item{
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                visible: _telephoneField.text.length > 0
                                width: 28
                                height: 28
                                Image{
                                    source: Assets.icons.close
                                    fillMode: Image.PreserveAspectFit
                                    anchors.fill: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: _telephoneField.text = ""
                                }
                            }
                        }
                        Label{
                            Layout.fillWidth: true
                            font: Typography.black.p
                            text: ""
                            color: Colors.danger.main
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col5.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col5
                        anchors.fill: parent
                        spacing: 4
                        Label{
                            Layout.fillWidth: true
                            font: Typography.bold.p
                            text: "Address na yo (Soki olingi)"
                        }
                        TextField{
                            id: _addressField
                            Layout.fillWidth: true
                            placeholderText: "koma address na yo"
                            font: Typography.black.p
                            rightPadding: 32
                            echoMode: "Normal"
                            Item{
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                visible: _addressField.text.length > 0
                                width: 28
                                height: 28
                                Image{
                                    source: Assets.icons.close
                                    fillMode: Image.PreserveAspectFit
                                    anchors.fill: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: _addressField.text = ""
                                }
                            }
                        }
                        Label{
                            Layout.fillWidth: true
                            font: Typography.black.p
                            text: ""
                            color: Colors.danger.main
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col6.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col6
                        anchors.fill: parent
                        spacing: 4
                        Label{
                            Layout.fillWidth: true
                            font: Typography.bold.p
                            text: "Email na bino"
                        }
                        TextField{
                            id: _emailField
                            Layout.fillWidth: true
                            placeholderText: "bo koma email na bino"
                            font: Typography.black.p
                            rightPadding: 32
                            echoMode: "Normal"
                            validator: RegularExpressionValidator { regularExpression: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                            Item{
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                visible: _emailField.text.length > 0
                                width: 28
                                height: 28
                                Image{
                                    source: Assets.icons.close
                                    fillMode: Image.PreserveAspectFit
                                    anchors.fill: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: _emailField.text = ""
                                }
                            }
                        }
                        Label{
                            id: _emailErrorLbl
                            Layout.fillWidth: true
                            font: Typography.black.p
                            text: ""
                            color: Colors.danger.main
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col7.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col7
                        anchors.fill: parent
                        spacing: 4
                        Label{
                            Layout.fillWidth: true
                            font: Typography.bold.p
                            text: "Mot de passe na bino"
                        }
                        TextField{
                            id: _passwordField
                            Layout.fillWidth: true
                            placeholderText: "koma mot de passe na bino"
                            font: Typography.black.p
                            rightPadding: 32
                            echoMode: TextField.Password
                            Item{
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: 10
                                visible: _passwordField.text.length > 0
                                width: 28
                                height: 28
                                Image{
                                    source: Assets.icons.visibility
                                    fillMode: Image.PreserveAspectFit
                                    anchors.fill: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if (_passwordField.echoMode === TextField.Normal){
                                            _passwordField.echoMode = TextField.Password
                                        }
                                        else {
                                            _passwordField.echoMode = TextField.Normal
                                        }
                                    }
                                }
                            }
                        }
                        Label{
                            id: _passwordErrorLbl
                            Layout.fillWidth: true
                            font: Typography.black.p
                            text: ""
                            color: Colors.danger.main
                        }
                    }
                }
                Button{
                    id: _btn1
                    Layout.alignment: Qt.AlignHCenter
                    text: "Bo S'inscrire"
                    font: Typography.bold.h6
                    Material.background: Colors.primary.main
                    Material.foreground: Colors.neutral.neutral10
                    Layout.fillWidth: true
                    //enabled: false
                    onClicked: {
                        const data = JS.signUpProfile(_signUpData)
                        _user.signUpUser(data)
                        _landingPageLoading.visible = true
                    }
                    Binding{
                        target: _btn1.background
                        property: "radius"
                        value: 20
                    }
                }
                Flow{
                    Layout.alignment: Qt.AlignHCenter
                    Label{
                        Layout.fillWidth: true
                        font: Typography.black.p
                        text: "Ozali deja abone?"
                        color: Colors.neutral.neutral100
                    }
                    Label{
                        Layout.fillWidth: true
                        font.pixelSize:  Qt.application.font.pixelSize
                        font.letterSpacing: 2
                        font.family: Typography.black.p.family
                        font.underline: _hover.hovered ? true : false
                        text: "Fina awa."
                        color: Colors.primary.hover
                        HoverHandler{
                            id: _hover
                            enabled: true
                            cursorShape: "PointingHandCursor"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                _landingPage._landingPageText = "KOTA NA SITE"
                                _landingPageStack.pop()
                            }
                        }
                    }
                }
            }
        }
    }
}
