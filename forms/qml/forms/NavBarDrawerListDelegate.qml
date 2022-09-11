import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import android_test_application
import "../scripts/constants.js" as Consts

ItemDelegate{
    id: _navBarDelegate
    width: parent.width
    height: _row3.implicitHeight * 1.4
    readonly property url _icon: modelData.icon
    readonly property string _label: modelData.label
    onClicked: {
        Consts.onNavBarListDelegateClicked(index,_navBarDrawer)
    }
    RowLayout{
        id: _row3
        anchors.fill: parent
        Item{
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 32
            Layout.preferredWidth: 32
            Image{
                id: _img1
                source: _navBarDelegate._icon
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                ColorOverlay{
                    source: _img1
                    anchors.fill: _img1
                    color: Colors.neutral.neutral10
                }
            }
        }
        Label{
            text: _navBarDelegate._label
            font: Typography.black.h6
            Material.foreground: Colors.neutral.neutral10
            Layout.alignment: Qt.AlignRight
            Layout.fillWidth: true
        }
    }
}
