#pragma once
#include <memory>
#include <tuple>

#include <QObject>
#include <QVariantMap>
#include <QVariantList>
#include <QVariant>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QStringList>

#include "videoslistmodel.hpp"

struct ApiKeys{
    ApiKeys() = delete;
    static constexpr const char* firebaseApi = "AIzaSyAi9lxhaqrWZEyJtLkA9Lce1pa_3GfJq1g";
    static constexpr const char* mongoDbApiKey = "do6C4yFQHuhZVkEmFXJQulHG2vugYt1DLJFQ2bqQSMjo8A0Bz0TmjjbERC81FwfL";
};

struct Endpoints{
    Endpoints() = delete;
    static constexpr const char* signUpWithEmailPassword = "https://identitytoolkit.googleapis.com/v1/accounts:signUp";
    static constexpr const char* signInWithEmailPassword = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword";
    static constexpr const char* firebaseStorage = "https://firebasestorage.googleapis.com/v0/b/kongo-history.appspot.com/o/";

    struct MongoEndpoints{
        MongoEndpoints() = delete;
        static constexpr const char* mongoDbBaseUrl = "https://data.mongodb-api.com/app/data-gxvdg/endpoint/data/v1/";
        static constexpr const char* insertOne = "action/insertOne";
        static constexpr const char* findOne = "action/findOne";
        static constexpr const char* find = "action/find";
        static constexpr const char* updateOne = "action/updateOne";
        static constexpr const char* deleteOne = "action/deleteOne";
    };

    struct MongoCollections{
        MongoCollections() = delete;
        static constexpr const char* users = "users";
        static constexpr const char* videos = "videos";
    };
};

struct Keys{
    static constexpr const char* key = "key";
    static constexpr const char* email = "email";
    static constexpr const char* password = "password";
    static constexpr const char* returnSecureToken = "returnSecureToken";
    static constexpr const char* idToken = "idToken";
    static constexpr const char* localId = "localId";
    static constexpr const char* telephone = "telephone";
    static constexpr const char* fullName = "fullName";
    static constexpr const char* error = "error";
    static constexpr const char* message = "message";
    static constexpr const char* kind = "kind";
    static constexpr const char* insertedId = "insertedId";
    static constexpr const char* document = "document";
    static constexpr const char* documents = "documents";
    static constexpr const char* watchedUsers = "watchedUsers";
    static constexpr const char* favorites = "favorites";
    static constexpr const char* address = "address";
};

namespace KEYS {
struct SignUpKeys{
    Q_GADGET
    Q_PROPERTY(QString email MEMBER email);
    Q_PROPERTY(QString password MEMBER password);
    Q_PROPERTY(QString returnSecureToken MEMBER returnSecureToken);
    Q_PROPERTY(QString address MEMBER address);
    Q_PROPERTY(QString telephone MEMBER telephone);
    Q_PROPERTY(QString fullName MEMBER fullName);
public:
    QString email = Keys::email;
    QString password = Keys::password;
    QString returnSecureToken = Keys::returnSecureToken;
    QString address = Keys::address;
    QString telephone = Keys::telephone;
    QString fullName = Keys::fullName;
};
};

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList favorites READ favorites WRITE setFavorites NOTIFY favoritesChanged);
private:
    using SignUpTuple = std::tuple<QString,QString,bool>;
    using SignInTuple = User::SignUpTuple;
    using Reply = QNetworkReply;
    using Manager = QNetworkAccessManager;
    using Request = QNetworkRequest;
private:
    std::unique_ptr<User::Manager> _manager = nullptr;
    std::unique_ptr<VideosListModel::VideosList> _videosList = nullptr;
    std::unique_ptr<VideosListModel::VideosList> _favoriteList = nullptr;
    QVariantMap _profile = {};
    QStringList _favorites = {};
private:
    const QJsonDocument signUpPayload(const User::SignUpTuple& signUpTuple);
    const QJsonDocument signInPayload(const User::SignInTuple& signUpTuple);
    User::Reply* signUpReply(const QJsonDocument& document);
    void addUserProfile(const QVariantMap& object);
    const QJsonDocument insertOneDocument(const QVariantMap& document,const QString& collection);
    const QJsonDocument findOneDocument(const QVariantMap& document,const QString& collection) const;
    const QJsonDocument findMultipleDocument(const QVariantMap &findMultiple, const QString collection);
    const QJsonDocument updateOneDocumentById(const QVariantMap &updateOne,const QString& updatingId,const QString collection);
    User::Reply* makeMongoPostRequest(const QString& endpoint,const QJsonDocument& document);
    User::Reply* findVideo(const QString& videoId);
    QString getMongoEndpoint(const char* endpoint);
    const QVariantMap filterById(const QString& identifier);
    const QStringList watchedVideo(const QVariantList watchedUsers);
    const QStringList videoLikes(const QVariantList videoLikes);
    const QStringList userFavoriteVideos(const QVariantList favorites,const QString& videoId);
    const QVariantList userComment(QJsonArray array,const QString &commentText);
private://connections
    void connectPercentageProgress(User::Reply* reply);
    void connectInsertReply(User::Reply* reply);
    void connectSignUpReply(User::Reply* reply,const QVariantMap& signUpMap);
    void connectFindUserByIdReply(User::Reply* reply);
    void connectSignInReply(User::Reply*);
    void connectWatchedUsersReply(User::Reply* reply,const QString videoId = "");
    void connectVideoLikedReply(User::Reply* reply,const QString videoId = "");
    void connectSaveVideo(User::Reply* saveVideoReply,const QString& videoId);
    void connectPostVideoComment(Reply *commentReply,const QString& videoId);
private slots:
    void findUserById(QString insertedId);
    void setFavorites(const QStringList& list);
public:
    explicit User(QObject *parent = nullptr);
    Q_INVOKABLE KEYS::SignUpKeys signUpKeys();
    Q_INVOKABLE void signUpUser(QVariantMap signUp);
    Q_INVOKABLE void signInUser(const QString email,const QString password);
    Q_INVOKABLE QString getEmail() const;
    Q_INVOKABLE QString getLocalId() const;
    Q_INVOKABLE QString getUserId() const;
    Q_INVOKABLE QString getTelephone() const;
    Q_INVOKABLE QString getAddress() const;
    Q_INVOKABLE QString getFullName() const;
    Q_INVOKABLE QVariantList getFavorites() const;
    Q_INVOKABLE void getAllVideos();
    Q_INVOKABLE void getUserFavorites();
    Q_INVOKABLE void addWatchedVideo(const QString videoId);
    Q_INVOKABLE void likeVideo(const QString videoId);
    Q_INVOKABLE void saveVideo(const QString videoId);
    Q_INVOKABLE void postVideoComment(const QString videoId, const QString commentText);
    QStringList favorites() const;
signals:
    void uploadProgressChanged(double);
    void signUpFailed(QString);
    void signInFailed(QString);
    void login();
    void insertedId(QString);
    void allVideos(VideosListModel::VideosList*);
    void newVideo(QVariantMap);
    void favoritesChanged();
    void favoriteVideos(VideosListModel::VideosList*);
    void startLoading();
};

