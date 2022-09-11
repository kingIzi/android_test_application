import QtQuick
import QtQuick.Controls.Material
import android_test_application

Item{
    id: _item5
    width: parent.width
    height: 100
    anchors.centerIn: parent
    visible: false
    property int _progress: 0
    Column{
        anchors.fill: parent
        BusyIndicator{
            id: _busyIndicator
            running: _item5.visible
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Item{
                id: _item1
                implicitHeight: 64
                implicitWidth: 64
                Item{
                    x: ((parent.width / 2) - 32)
                    y: ((parent.height / 2) - 32)
                    width: _item1.implicitWidth
                    height: _item1.implicitHeight
                    opacity: _busyIndicator.running ? 1 : 0
                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 250
                        }
                    }
                    RotationAnimator {
                        target: _item1
                        running: _busyIndicator.visible && _busyIndicator.running
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        duration: 1250
                    }
                    Repeater {
                        id: repeater
                        model: 6
                        Rectangle {
                            id: delegate
                            x: _item1.width / 2 - width / 2
                            y: _item1.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: Colors.primary.main
                            required property int index
                            transform: [
                                Translate {
                                    y: -Math.min(_item1.width, _item1.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: delegate.index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
        }
        Label{
            id: _progressLbl
            font: Typography.black.h6
            text: _item5._progress + "%"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
    }
}
