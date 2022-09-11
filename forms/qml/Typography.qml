pragma Singleton
import QtQuick

Item {
    FontLoader {
        id: _regularFont
        source: "qrc:/android_test_application/forms/fonts/static/Montserrat-Regular.ttf"
    }
    FontLoader {
        id: _boldFont
        source: "qrc:/android_test_application/forms/fonts/static/Montserrat-Black.ttf"
    }
    readonly property QtObject black: QtObject{
        readonly property font p:Qt.font({
                                             family: _regularFont.name,
                                             pixelSize: Qt.application.font.pixelSize,
                                             letterSpacing: 2
                                         })
        readonly property font h7:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 1.4,
                                              letterSpacing: 2
                                          })
        readonly property font h6:Qt.font({
                                             family: _regularFont.name,
                                             pixelSize: Qt.application.font.pixelSize * 2,
                                             letterSpacing: 2
                                         })
        readonly property font h5:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 3,
                                              letterSpacing: 2
                                          })
        readonly property font h4:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 4,
                                              letterSpacing: 2
                                          })
        readonly property font h3:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 5,
                                              letterSpacing: 2
                                          })
        readonly property font h2:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 6,
                                              letterSpacing: 2
                                          })
        readonly property font h1:Qt.font({
                                              family: _regularFont.name,
                                              pixelSize: Qt.application.font.pixelSize * 7,
                                              letterSpacing: 2
                                          })

    }
    readonly property QtObject bold: QtObject{
        readonly property font p:Qt.font({
                                             family: _boldFont.name,
                                             pixelSize: Qt.application.font.pixelSize,
                                             letterSpacing: 2,
                                         })
        readonly property font h6:Qt.font({
                                             family: _boldFont.name,
                                             pixelSize: Qt.application.font.pixelSize * 2,
                                             letterSpacing: 2,
                                         })
    }
}
