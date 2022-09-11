import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application
import "../forms"
import "../scripts/constants.js" as JS

Page{
    id: _landingPage
    Material.background: Colors.primary.main
    property string _landingPageText: "KOTA NA SITE"
    Component{
        id: _loginComponent
        LoginForm{
            id: _loginForm
            Connections{
                target: _loginForm
                function onOpenRegisterPage(){
                    _landingPage._landingPageText = "Bo S'inscrire"
                    _landingPageStack.push(_registerComponent)
                }
                function onForgotPassword(){
                    _landingPage._landingPageText = "Obosani fongola"
                    _landingPageStack.push(_forgotPassword)
                }
                function onStartLoading(){
                    _landingPageLoading.visible = true
                }
            }
            Connections{
                target: _user
                function onSignInFailed(message){
                    _loginForm._emailError.text = message
                    _loginForm._passwordError.text = message
                    _landingPageLoading.visible = false
                }
                function onLogin(){
                    _landingPageLoading.visible = false
                    JS.onNavBarListDelegateClicked(0,_drawer)
                }
            }
        }
    }
    Component{
        id: _registerComponent
        RegisterForm{
            id: _regForm
            Connections{
                target: _user
                function onSignUpFailed(message){
                    console.log(message)
                    _regForm._emailError.text = message
                    _regForm._passwordError.text = message
                    _landingPageLoading.visible = false
                }
                function onLogin(){
                    _landingPageLoading.visible = false
                    JS.onNavBarListDelegateClicked(0,_drawer)
                }
            }
        }
    }
    Component{
        id: _forgotPassword
        ForgotPasswordForm{}
    }
    Item{
        anchors.fill: parent
        Loading{
            id: _landingPageLoading
            visible: false
            z: 5
        }
        ColumnLayout{
            id: _col1
            anchors.fill: parent
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                Label{
                    id: _landingPageText
                    font: Typography.black.h5
                    text: _landingPage._landingPageText
                    anchors.centerIn: parent
                    horizontalAlignment: "AlignHCenter"
                    color: Colors.neutral.neutral10
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Rectangle{
                    id: _bg
                    color: Colors.neutral.neutral10
                    anchors.fill: parent
                    radius: 30
                    Rectangle{
                        width: parent.width
                        height: _bg.radius
                        color: _bg.color
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                    }
                    StackView{
                        id: _landingPageStack
                        anchors.fill: parent
                        anchors.margins: 20
                        initialItem: _loginComponent
                    }
                }
            }
        }
    }
}


