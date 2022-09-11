#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QLocale>
#include <QTranslator>
#include <QSsl>

#include "commentslistmodel.hpp"
#include "user.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "android_test_application_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }
    User user;
    const auto filePath = u"qrc:/android_test_application/forms/qml/main.qml"_qs;
    QQmlApplicationEngine engine;
    qmlRegisterType<VideosListModel>("VideosList",1,0,"VideosListModel");
    qmlRegisterType<CommentsListModel>("CommentsList",1,0,"CommentsListModel");
    const QUrl url(filePath);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("_user",&user);
    engine.load(url);

    return app.exec();
}
