pragma Singleton
import QtQuick

QtObject {
    readonly property QtObject icons: QtObject{
        readonly property url person: "qrc:/android_test_application/forms/svg_icons/person_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url menu: "qrc:/android_test_application/forms/svg_icons/menu_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url visibility: "qrc:/android_test_application/forms/svg_icons/visibility_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url visibilityOff: "qrc:/android_test_application/forms/svg_icons/visibility_off_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url lock: "qrc:/android_test_application/forms/svg_icons/lock_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url close: "qrc:/android_test_application/forms/svg_icons/close_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url refresh: "qrc:/android_test_application/forms/svg_icons/refresh_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url home: "qrc:/android_test_application/forms/svg_icons/home_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url favorite: "qrc:/android_test_application/forms/svg_icons/favorite_FILL0_wght400_GRAD0_opsz48.svg"
        readonly property url arrowBack: "qrc:/android_test_application/forms/svg_icons/arrow_back_FILL0_wght400_GRAD0_opsz48.svg"
    }
    readonly property QtObject images: QtObject{
        readonly property url africanWoman: "qrc:/android_test_application/forms/assets/africanWoman.jpg"
        readonly property url congoHands: "qrc:/android_test_application/forms/assets/congoHands.jpg"
    }
    readonly property QtObject res: QtObject{
        readonly property url manix: "qrc:/android_test_application/forms/assets/manix.mp4"
    }
}
