pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject{
    readonly property QtObject primary: QtObject{
        readonly property color main: Qt.color("#5E47D2")
        readonly property color bgColor: Qt.color("#F7F5FF")
        readonly property color pressed: Qt.color("#220F80")
        readonly property color hover: Qt.color("#694DF9")
        readonly property color focus: Qt.color("#E2DCFF")
        readonly property color border: Qt.color("#BCB0F5")
    }

    readonly property QtObject success: QtObject{
        readonly property color main: Qt.color("#21725E")
        readonly property color bgColor: Qt.color("#E7FAF5")
        readonly property color pressed: Qt.color("#164C3F")
        readonly property color hover: Qt.color("#1B5F4E")
        readonly property color focus: Qt.color("#C8EBE2")
        readonly property color border: Qt.color("#B5D0C9")
    }

    readonly property QtObject warning: QtObject{
        readonly property color main: Qt.color("#E0CE2C")
        readonly property color bgColor: Qt.color("#FEFADC")
        readonly property color pressed: Qt.color("#95891D")
        readonly property color hover: Qt.color("#BBAC25")
        readonly property color focus: Qt.color("#FDF8CF")
        readonly property color border: Qt.color("#F5EFB9")
    }

    readonly property QtObject danger: QtObject{
        readonly property color main: Qt.color("#A82525")
        readonly property color bgColor: Qt.color("#FFE8E8")
        readonly property color pressed: Qt.color("#541212")
        readonly property color hover: Qt.color("#8C1F1F")
        readonly property color focus: Qt.color("#FFDFDF")
        readonly property color border: Qt.color("#E2B6B6")
    }

    readonly property QtObject info: QtObject{
        readonly property color main: Qt.color("#0023DD")
        readonly property color bgColor: Qt.color("#EBEEFF")
        readonly property color pressed: Qt.color("#001793")
        readonly property color hover: Qt.color("#001DB8")
        readonly property color focus: Qt.color("#E2E7FF")
        readonly property color border: Qt.color("#AAB6F4")
    }

    readonly property QtObject neutral: QtObject{
        readonly property color neutral100: Qt.color("#0A0A0A")
        readonly property color neutral90: Qt.color("#424242")
        readonly property color neutral80: Qt.color("#616161")
        readonly property color neutral70: Qt.color("#757575")
        readonly property color neutral60: Qt.color("#9E9E9E")
        readonly property color neutral50: Qt.color("#C2C2C2")
        readonly property color neutral40: Qt.color("#E0E0E0")
        readonly property color neutral30: Qt.color("#EDEDED")
        readonly property color neutral20: Qt.color("#F5F5F5")
        readonly property color neutral10: Qt.color("#FFFFFF")
        readonly property color neutral0: "transparent"
    }
}
