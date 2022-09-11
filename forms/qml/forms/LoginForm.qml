import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application

Item{
    id: _loginForm
    signal openRegisterPage()
    signal forgotPassword()
    signal startLoading()
    readonly property alias _emailError: _emailErrorLbl
    readonly property alias _passwordError: _passwordErrorLbl
    Timer{
        id: _timer
        interval: 1000
        triggeredOnStart: false
        running: false
        repeat: false
    }
    ColumnLayout{
        id: _col2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
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
                    text: "Email na bino"
                }
                TextField{
                    id: _emailField
                    Layout.fillWidth: true
                    placeholderText: "bo koma email na bino"
                    font: Typography.black.p
                    rightPadding: 32
                    echoMode: "Normal"
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
            Layout.preferredHeight: _col4.implicitHeight
            Layout.alignment: Qt.AlignTop
            ColumnLayout{
                id: _col4
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
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: _row1.implicitHeight
            RowLayout{
                id: _row1
                anchors.fill: parent
                CheckBox{
                    id: _rememberMe
                    enabled: true
                    Material.accent: Colors.primary.main
                    text: "Kanisa ngai"
                    font: Typography.black.p
                }
                Label{
                    Layout.alignment: Qt.AlignRight
                    font.pixelSize:  Qt.application.font.pixelSize
                    font.letterSpacing: 2
                    font.family: Typography.black.p.family
                    font.underline: _hover2.hovered ? true : false
                    text: "Obosani mot de passe?"
                    horizontalAlignment: "AlignRight"
                    color: Colors.primary.hover
                    HoverHandler{
                        id: _hover2
                        enabled: true
                        cursorShape: "PointingHandCursor"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            _loginForm.forgotPassword()
                        }
                    }
                }
            }
        }

        Button{
            id: _btn1
            Layout.alignment: Qt.AlignHCenter
            text: "Kota"
            font: Typography.bold.h6
            Material.background: Colors.primary.main
            Material.foreground: Colors.neutral.neutral10
            Layout.fillWidth: true
            onClicked: {
                _user.signInUser(_emailField.text,_passwordField.text)
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
                text: "Oza abone te?"
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
                        _loginForm.openRegisterPage()
                    }
                }
            }
        }
    }
}
