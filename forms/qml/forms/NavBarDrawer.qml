import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import android_test_application

Drawer {
    id: _navBarDrawer
    width: (_root.width * 0.444)
    height: _root.height
    Material.background: Colors.primary.main
    edge: Qt.LeftEdge
    Item{
        id: _item5
        anchors.fill: parent
        anchors.topMargin: 30
        ListView{
            id: _navBarDrawerListView
            anchors.fill: parent
            spacing: 8
            model: [{
                    "icon": Assets.icons.home,
                    "label": "Home"
                },
                {
                    "icon": Assets.icons.favorite,
                    "label": "Favorite"
                },
                {
                    "icon": Assets.icons.person,
                    "label": "Profile"
                }
            ]
            delegate: NavBarDrawerListDelegate{
                id: _listDelegate
            }
        }
    }
}
