cmake_minimum_required(VERSION 3.16)

project(android_test_application VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    if (ANDROID_ABI STREQUAL "arm64-v8a")
        set(ANDROID_EXTRA_LIBS
            libs/libcrypto-1_1.dll
            libs/libssl-1_1.dll)
            #${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
            #${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
    endif()
endif()
#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt6 6.2 COMPONENTS Quick Network Core Multimedia REQUIRED)


set_source_files_properties(forms/qml/Typography.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

set_source_files_properties(forms/qml/Colors.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

set_source_files_properties(forms/qml/Assets.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

set(SOURCE_FILES
    src/main.cpp
    src/user.cpp
    src/videodatalist.cpp
    src/videoslistmodel.cpp
    src/commentslistmodel.cpp

    include/user.hpp
    include/videodatalist.hpp
    include/videoslistmodel.hpp
    include/commentslistmodel.hpp
)

include_directories(include/)

set(QML_FILES
    forms/qml/main.qml
    forms/qml/Colors.qml
    forms/qml/Typography.qml
    forms/qml/Assets.qml

    forms/qml/pages/LandingPage.qml
    forms/qml/pages/HomePage.qml
    forms/qml/pages/FavoritePage.qml
    forms/qml/pages/StreamingPage.qml
    forms/qml/pages/ProfilePage.qml

    forms/qml/forms/StreamingPageDetails.qml
    forms/qml/forms/LoginForm.qml
    forms/qml/forms/RegisterForm.qml
    forms/qml/forms/NavBar.qml
    forms/qml/forms/Loading.qml
    forms/qml/forms/VideoDelegate.qml
    forms/qml/forms/NavBarDrawer.qml
    forms/qml/forms/NavBarDrawerListDelegate.qml
    forms/qml/forms/CommentsForm.qml
    forms/qml/forms/ForgotPasswordForm.qml

    forms/qml/mediaplayer/MainVideoPlayer.qml
    forms/qml/mediaplayer/AudioControl.qml
    forms/qml/mediaplayer/MetadataInfo.qml
    forms/qml/mediaplayer/PlaybackControl.qml
    forms/qml/mediaplayer/PlaybackRateControl.qml
    forms/qml/mediaplayer/PlaybackSeekControl.qml
    forms/qml/mediaplayer/PlayerMenuBar.qml
    forms/qml/mediaplayer/TracksInfo.qml

    forms/qml/scripts/constants.js
)

qt_add_executable(appandroid_test_application
    ${SOURCE_FILES}
)

set(SYSTEM_ASSETS
    forms/fonts/static/Montserrat-Regular.ttf
    forms/fonts/static/Montserrat-Black.ttf

    forms/svg_icons/person_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/lock_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/close_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/menu_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/visibility_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/visibility_off_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/refresh_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/home_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/favorite_FILL0_wght400_GRAD0_opsz48.svg
    forms/svg_icons/arrow_back_FILL0_wght400_GRAD0_opsz48.svg

    forms/assets/africanWoman.jpg
    forms/assets/congoHands.jpg
)

qt_add_qml_module(appandroid_test_application
    URI android_test_application
    VERSION 1.0
    QML_FILES ${QML_FILES}
    RESOURCES ${SYSTEM_ASSETS}
)

set_target_properties(appandroid_test_application PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appandroid_test_application
    PRIVATE Qt6::Quick Qt6::Network Qt6::Core Qt6::Multimedia)

#uncomment line below for android build
#install(TARGETS appandroid_test_application
#    BUNDLE DESTINATION .
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
