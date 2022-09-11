import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application

Item{
    ColumnLayout{
        anchors.fill: parent
        Flow{
            Layout.fillWidth: true
            flow: Flow.TopToBottom
            Label{
                font: Typography.black.h6
                text: "Obosani mot de passe na yo?"
                width: parent.width
                wrapMode: "WordWrap"
                horizontalAlignment: "AlignHCenter"
                color: Colors.neutral.neutral100
            }
            Label{
                font: Typography.black.p
                width: parent.width
                wrapMode: "WordWrap"
                text: "Kobanga te! Tindela biso email na yo"
                horizontalAlignment: "AlignHCenter"
                color: Colors.neutral.neutral100
            }
        }
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
                Button{
                    Layout.alignment: Qt.AlignHCenter
                    icon.source: Assets.icons.home
                    font: Typography.black.p
                    text: "Toyebi yo, tala na boite email na yo"
                    Material.foreground: Colors.success.main
                    Material.background: Colors.neutral.neutral0
                }
            }
        }
        Button{
            id: _btn3
            Layout.alignment: Qt.AlignHCenter
            text: "Tinda email"
            font: Typography.bold.h6
            Material.background: Colors.primary.main
            Material.foreground: Colors.neutral.neutral10
            Layout.fillWidth: true
            onClicked: {
                console.log("email sent")
            }

            Binding{
                target: _btn3.background
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
