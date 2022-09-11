import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import android_test_application


Pane {
    id: _navBar
    width: _root.width
    height: 70
    Material.background: Colors.primary.main
    Material.elevation: 4
    property url _leftIcon: Assets.icons.menu
    property string _pageTitle: "Home"
    state: _leftIcon === Assets.icons.menu ? "NotNavigating" : "Navigating"
    signal popBack()
    RowLayout{
        id: _row2
        anchors.fill: parent
        RoundButton{
            icon.color: Colors.neutral.neutral10
            icon.source: _navBar._leftIcon
            Layout.alignment: Qt.AlignLeft
            Material.background: Colors.neutral.neutral0
            padding: 10
            onClicked: {
                if (_navBar.state === "NotNavigating"){
                    _navDrawer.open()
                }
                else {
                    _navBar.popBack()
                }
            }
        }
        Label{
            id: _titleText
            text: _navBar._pageTitle
            font: Typography.black.h6
            padding: 10
            Layout.fillWidth: true
            Material.foreground: Colors.neutral.neutral10
        }
        RoundButton{
            icon.color: Colors.neutral.neutral10
            icon.source: Assets.icons.refresh
            Layout.alignment: Qt.AlignRight
            Material.background: Colors.neutral.neutral0
            padding: 10
            visible: _navBar.state === "NotNavigating"
        }
    }
}
