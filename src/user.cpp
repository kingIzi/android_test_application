#include <QUrl>
#include <QUrlQuery>
#include "user.hpp"

const QJsonDocument User::signUpPayload(const SignUpTuple &signUpTuple)
{
    KEYS::SignUpKeys keys;
    const QVariantMap map = {
        {keys.email,std::get<0>(signUpTuple)},
        {keys.password,std::get<1>(signUpTuple)},
        {keys.returnSecureToken,std::get<2>(signUpTuple)}
    };
    return QJsonDocument::fromVariant(map);
}

const QJsonDocument User::signInPayload(const SignInTuple &signInTuple)
{
    KEYS::SignUpKeys keys;
    const QVariantMap map = {
        {keys.email,std::get<0>(signInTuple)},
        {keys.password,std::get<1>(signInTuple)},
        {keys.returnSecureToken,std::get<2>(signInTuple)}
    };
    return QJsonDocument::fromVariant(map);
}

User::Reply *User::signUpReply(const QJsonDocument &document)
{
    const auto signUpEndpoint = Endpoints::signUpWithEmailPassword;

    QUrlQuery query;
    query.addQueryItem(Keys::key,ApiKeys::firebaseApi);
    QUrl url(signUpEndpoint);
    url.setQuery(query);

    User::Request request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    return this->_manager->post(request,document.toJson());
}

void User::addUserProfile(const QVariantMap &object)
{
    const auto keys = object.keys();
    std::for_each(keys.begin(),keys.end(),[=](const QString& key){
        this->_profile.insert(key,object.value(key));
    });
    this->setFavorites(this->_profile.value(Keys::favorites).toStringList());
}

const QJsonDocument User::insertOneDocument(const QVariantMap &document, const QString &collection)
{
    const QVariantMap insert = {
        {"dataSource","Cluster0"},
        {"database","project_database"},
        {"collection",collection},
        {"document",document}
    };
    return QJsonDocument::fromVariant(insert);
}

const QJsonDocument User::findOneDocument(const QVariantMap &document, const QString &collection) const
{
    const QVariantMap find = {
        {"dataSource","Cluster0"},
        {"database","project_database"},
        {"collection",collection},
        {"filter",document}
    };
    return QJsonDocument::fromVariant(find);
}

const QJsonDocument User::findMultipleDocument(const QVariantMap &findMultiple, const QString collection)
{
    const QVariantMap multiple = {
            {"dataSource","Cluster0"},
            {"database","project_database"},
            {"collection",collection},
            {"filter",findMultiple}
        };
    return QJsonDocument::fromVariant(multiple);
}

const QJsonDocument User::updateOneDocumentById(const QVariantMap &updateOne, const QString& updatingId,const QString collection)
{
    const auto id = this->filterById(updatingId);
    const QVariantMap update = {
        {"$set",updateOne}
    };
    const QVariantMap find = {
        {"dataSource","Cluster0"},
        {"database","project_database"},
        {"collection",collection},
        {"filter",id},
        {"update",update}
    };
    return QJsonDocument::fromVariant(find);
}

User::Reply *User::makeMongoPostRequest(const QString &endpoint, const QJsonDocument &document)
{
    User::Request request((QUrl(endpoint)));
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    request.setRawHeader("Access-Control-Request-Headers","*");
    request.setRawHeader("api-key",ApiKeys::mongoDbApiKey);
    return this->_manager->post(request,document.toJson());
}

User::Reply *User::findVideo(const QString &videoId)
{
    const auto videoMap = this->filterById(videoId);
    const auto videoDocument = this->findOneDocument(videoMap,Endpoints::MongoCollections::videos);
    const auto endpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::findOne);
    return this->makeMongoPostRequest(endpoint,videoDocument);
}

QString User::getMongoEndpoint(const char *endpoint)
{
    return QString(Endpoints::MongoEndpoints::mongoDbBaseUrl) + endpoint;
}

const QVariantMap User::filterById(const QString &identifier)
{
    const QVariantMap insertedObj = {
        {"$oid",identifier}
    };
    const QVariantMap filter = {
        {"_id",insertedObj}
    };
    return filter;
}

const QStringList User::watchedVideo(const QVariantList watchedUsers)
{
    auto users = qvariant_cast<QVariant>(watchedUsers).toStringList();
    if (!users.contains(this->getLocalId())){
        users.push_back(this->getLocalId());
    }
    else if (users.contains(this->getLocalId())){
        return QStringList();
    }
    users.removeDuplicates();
    return users;
}

const QStringList User::videoLikes(const QVariantList videoLikes)
{
    auto likes = qvariant_cast<QVariant>(videoLikes).toStringList();
    if (!likes.contains(this->getLocalId())){
        likes.push_back(this->getLocalId());
    }
    else if (likes.contains(this->getLocalId())){
        likes.removeOne(this->getLocalId());
    }
    likes.removeDuplicates();
    return likes;
}

const QStringList User::userFavoriteVideos(const QVariantList favorites, const QString &videoId)
{
    auto favoritesList = qvariant_cast<QVariant>(favorites).toStringList();
    if (!favoritesList.contains(videoId)){
        favoritesList.push_back(videoId);
    }
    else if (favoritesList.contains(videoId)){
        favoritesList.removeOne(videoId);
    }
    favoritesList.removeDuplicates();
    qDebug() << favoritesList;
    return favoritesList;
}

const QVariantList User::userComment(QJsonArray array, const QString &commentText)
{
    QJsonObject object;
    object.insert(Keys::email,this->getEmail());
    object.insert("commentText",commentText);
    object.insert("published",QDate::currentDate().toString(Qt::RFC2822Date));
    array.push_back(object);
    return array.toVariantList();
}

void User::connectPercentageProgress(Reply *reply)
{
    QObject::connect(reply,&User::Reply::uploadProgress,[=](qint64 sent,qint64 total){
        const auto percent = 100;
        const auto progress = ((sent * 100) / total);
        emit User::uploadProgressChanged(progress);
    });
}

void User::connectInsertReply(Reply *reply)
{
    //this->connectPercentageProgress(reply);
    QObject::connect(reply,&User::Reply::readyRead,[=](){
        const auto document = QJsonDocument::fromJson(reply->readAll());
        const auto id = document.object().value(Keys::insertedId).toString();
        emit User::insertedId(id);
        reply->deleteLater();
    });
}

void User::connectSignUpReply(Reply *reply,const QVariantMap& signUpMap)
{
    QObject::connect(reply,&User::Reply::readyRead,[=](){
         const auto document = QJsonDocument::fromJson(reply->readAll());
         if (document.object().contains(Keys::error)){
             const auto error = document.object().value(Keys::error).toObject();
             const auto message = error.value(Keys::message).toString();
             emit User::signUpFailed(message);
         }
         else if (document.object().contains(Keys::kind)){
             const auto object = document.object().toVariantMap();
             this->addUserProfile(object);
             const auto insertDoc = this->insertOneDocument(signUpMap,"users");
             const auto insertOneEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::insertOne);
             const auto insertReply = this->makeMongoPostRequest(insertOneEndpoint,insertDoc);
             this->connectInsertReply(insertReply);
             QObject::connect(this,&User::insertedId,this,&User::findUserById);
         }
         reply->deleteLater();
    });
}

void User::connectFindUserByIdReply(Reply *reply)
{
    QObject::connect(reply,&User::Reply::readyRead,[=](){
        const auto document = QJsonDocument::fromJson(reply->readAll());
        const auto userObj = document.object().value(Keys::document).toObject().toVariantMap();
        this->addUserProfile(userObj);
        emit User::login();
        reply->deleteLater();
    });
}

void User::connectSignInReply(Reply *signInReply)
{
    QObject::connect(signInReply,&User::Reply::readyRead,[this,signInReply](){
        const auto document = QJsonDocument::fromJson(signInReply->readAll());
        if (document.object().contains(Keys::error)){
            const auto error = document.object().value(Keys::error).toObject();
            const auto message = error.value(Keys::message).toString();
            emit User::signInFailed(message);
        }
        else if (document.object().contains(Keys::kind)){
            const auto object = document.object().toVariantMap();
            this->addUserProfile(object);
            const auto findOneDocument = this->findOneDocument({{Keys::email,this->getEmail()}},Endpoints::MongoCollections::users);
            const auto findOneEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::findOne);
            const auto findReply = this->makeMongoPostRequest(findOneEndpoint,findOneDocument);
            this->connectFindUserByIdReply(findReply);
        }
        else{
            emit User::signInFailed("Ozangi connexion internet.");
        }
        signInReply->deleteLater();
    });
}

void User::connectWatchedUsersReply(Reply *reply,const QString videoId)
{
    QObject::connect(reply,&User::Reply::readyRead,[reply,videoId,this](){
        const auto videoReply = this->findVideo(videoId);
        if (!videoId.isEmpty()){
            QObject::connect(videoReply,&User::Reply::readyRead,[videoReply,this](){
                const auto document = QJsonDocument::fromJson(videoReply->readAll());
                const auto videoMap = document.object().value(Keys::document).toObject().toVariantMap();
                emit User::newVideo(videoMap);
                videoReply->deleteLater();
            });
        }
        reply->deleteLater();
    });
}

void User::connectVideoLikedReply(Reply *reply, const QString videoId)
{
    QObject::connect(reply,&User::Reply::readyRead,[reply,videoId,this](){
        const auto videoReply = this->findVideo(videoId);
        if (!videoId.isEmpty()){
            QObject::connect(videoReply,&User::Reply::readyRead,[videoReply,this](){
                const auto document = QJsonDocument::fromJson(videoReply->readAll());
                const auto videoMap = document.object().value(Keys::document).toObject().toVariantMap();
                emit User::newVideo(videoMap);
                videoReply->deleteLater();
            });
        }
        reply->deleteLater();
    });
}

void User::connectSaveVideo(Reply *saveVideoReply, const QString &videoId)
{
    QObject::connect(saveVideoReply,&User::Reply::readyRead,[saveVideoReply,videoId,this](){
        this->findUserById(this->getUserId());
        const auto videoReply = this->findVideo(videoId);
        QObject::connect(videoReply,&User::Reply::readyRead,[=](){
            const auto document = QJsonDocument::fromJson(videoReply->readAll());
            const auto video = document.object().value(Keys::document).toObject().toVariantMap();
            emit User::newVideo(video);
            videoReply->deleteLater();
        });
        saveVideoReply->deleteLater();
    });
}

void User::connectPostVideoComment(Reply *commentReply, const QString &videoId)
{
    QObject::connect(commentReply,&User::Reply::readyRead,[=](){
        const auto videoReply = this->findVideo(videoId);
        QObject::connect(videoReply,&User::Reply::readyRead,[=](){
            const auto document = QJsonDocument::fromJson(videoReply->readAll());
            const auto video = document.object().value("document").toObject().toVariantMap();
            emit User::newVideo(video);
            videoReply->deleteLater();
        });
        commentReply->deleteLater();
    });
}

void User::findUserById(QString insertedId)
{
    const auto findUser = this->findOneDocument(this->filterById(insertedId),Endpoints::MongoCollections::users);
    const auto findOneEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::findOne);
    const auto userReply = this->makeMongoPostRequest(findOneEndpoint,findUser);
    this->connectFindUserByIdReply(userReply);
}

void User::setFavorites(const QStringList &list)
{
    if (this->_favorites != list){
        this->_favorites = list;
        emit User::favoritesChanged();
    }
}

User::User(QObject *parent)
    : QObject{parent},
      _manager(std::make_unique<User::Manager>(this))
{

}

//sign up keys
KEYS::SignUpKeys User::signUpKeys()
{
    return KEYS::SignUpKeys();
}

void User::signUpUser(QVariantMap signUp)
{
    const auto emailPassword = [&signUp](const KEYS::SignUpKeys&& keys){
        const auto email = signUp.value(keys.email).toString();
        const auto password = signUp.value(keys.password).toString();
        signUp.remove(keys.password);
        return std::make_pair(email,password);
    }(KEYS::SignUpKeys());
    const auto signUpTuple = std::make_tuple(emailPassword.first,emailPassword.second,true);
    const auto signUpDocument = this->signUpPayload(signUpTuple);
    const auto reply = this->signUpReply(signUpDocument);
    this->connectSignUpReply(reply,signUp);
}

void User::signInUser(const QString email, const QString password)
{
    const auto signInEndpoint = Endpoints::signInWithEmailPassword;
    QUrl url(signInEndpoint);
    QUrlQuery query;
    query.addQueryItem(Keys::key,ApiKeys::firebaseApi);
    url.setQuery(query);

    const auto signInTuple = std::make_tuple(email,password,true);
    const auto signInPayload = this->signInPayload(signInTuple);
    User::Request request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    const auto reply = this->_manager->post(request,signInPayload.toJson());
    this->connectSignInReply(reply);
}

QString User::getEmail() const
{
    return this->_profile.value(Keys::email).toString();
}

QString User::getLocalId() const
{
    return this->_profile.value(Keys::localId).toString();
}

QString User::getUserId() const
{
    return this->_profile.value("_id").toString();
}

QString User::getTelephone() const
{
    return this->_profile.value(Keys::telephone).toString();
}

QString User::getAddress() const
{
    return this->_profile.value(Keys::address).toString();
}

QString User::getFullName() const
{
    return this->_profile.value(Keys::fullName).toString();
}

QVariantList User::getFavorites() const
{
    const auto favorites = this->_profile.value(Keys::favorites).toList();
    return static_cast<QVariantList>(favorites);
}

void User::getAllVideos()
{
    const auto multiple = this->findMultipleDocument({},Endpoints::MongoCollections::videos);
    const auto findMultiEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::find);
    const auto multipleReply = this->makeMongoPostRequest(findMultiEndpoint,multiple);
    QObject::connect(multipleReply,&User::Reply::readyRead,[=](){
        const auto documents = QJsonDocument::fromJson(multipleReply->readAll());
        const auto videosArray = documents.object().value(Keys::documents).toArray();
        QList<Video> videos; videos.reserve(videosArray.size());
        std::for_each(videosArray.begin(),videosArray.end(),[&videos](const QJsonValue& value){
            const auto videoObj = value.toObject().toVariantMap();
            const auto video = VideosDataList::createVideo(videoObj);
            videos.push_back(video);
        });
        this->_videosList = std::make_unique<VideosDataList>(videos,this);
        emit User::allVideos(this->_videosList.get());
        multipleReply->deleteLater();
    });
}

void User::getUserFavorites()
{
    emit User::startLoading();
    const auto multiple = this->findMultipleDocument({},Endpoints::MongoCollections::videos);
    const auto findMultiEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::find);
    const auto multipleReply = this->makeMongoPostRequest(findMultiEndpoint,multiple);
    QObject::connect(multipleReply,&User::Reply::readyRead,[multipleReply,this](){
        const auto documents = QJsonDocument::fromJson(multipleReply->readAll());
        const auto videos = VideosDataList::createFavoriteVideosList(documents,this->_favorites);
        qDebug() << videos.size();
        this->_favoriteList = std::make_unique<VideosDataList>(videos,this);
        emit User::favoriteVideos(this->_favoriteList.get());
        multipleReply->deleteLater();
    });
}

void User::addWatchedVideo(const QString videoId)
{
    const auto videoReply = this->findVideo(videoId);
    QObject::connect(videoReply,&User::Reply::readyRead,[=](){
        const auto document = QJsonDocument::fromJson(videoReply->readAll());
        auto videoMap = document.object().value(Keys::document).toObject().toVariantMap();
        const auto watchedUsers = this->watchedVideo(videoMap.value(Keys::watchedUsers).toJsonValue().toArray().toVariantList());
        if (!watchedUsers.isEmpty()){
            videoMap.insert(Keys::watchedUsers,watchedUsers); videoMap.remove("_id");
            const auto update = this->updateOneDocumentById(videoMap,videoId,Endpoints::MongoCollections::videos);
            const auto updateEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::updateOne);
            const auto updateReply = this->makeMongoPostRequest(updateEndpoint,update);
            this->connectWatchedUsersReply(updateReply,videoId);
        }
        videoReply->deleteLater();
    });
}

void User::likeVideo(const QString videoId)
{
    const auto videoReply = this->findVideo(videoId);
    QObject::connect(videoReply,&User::Reply::readyRead,[videoReply,videoId,this](){
        const auto document =  QJsonDocument::fromJson(videoReply->readAll());
        auto videoMap = document.object().value(Keys::document).toObject().toVariantMap();
        const auto likes = this->videoLikes(videoMap.value("likes").toJsonValue().toArray().toVariantList());
        videoMap.insert("likes",likes); videoMap.remove("_id");
        const auto update = this->updateOneDocumentById(videoMap,videoId,Endpoints::MongoCollections::videos);
        const auto updateEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::updateOne);
        const auto updateReply = this->makeMongoPostRequest(updateEndpoint,update);
        this->connectVideoLikedReply(updateReply,videoId);
        videoReply->deleteLater();
    });
}

void User::saveVideo(const QString videoId)
{
    const auto findOneDocument = this->findOneDocument(this->filterById(this->getUserId()),Endpoints::MongoCollections::users);
    const auto findEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::findOne);
    const auto findReply = this->makeMongoPostRequest(findEndpoint,findOneDocument);
    QObject::connect(findReply,&User::Reply::readyRead,[=](){
        const auto document = QJsonDocument::fromJson(findReply->readAll());
        auto userObj = document.object().value(Keys::document).toObject().toVariantMap();
        const auto favorites = this->userFavoriteVideos(userObj.value(Keys::favorites).toJsonValue().toArray().toVariantList(),videoId);
        userObj.insert(Keys::favorites,favorites); userObj.remove("_id");
        this->setFavorites(favorites);
        const auto update = this->updateOneDocumentById(userObj,this->getUserId(),Endpoints::MongoCollections::users);
        const auto updateOneEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::updateOne);
        const auto updateReply = this->makeMongoPostRequest(updateOneEndpoint,update);
        this->connectSaveVideo(updateReply,videoId);
        findReply->deleteLater();
    });
}

void User::postVideoComment(const QString videoId, const QString commentText)
{
    const auto videoReply = this->findVideo(videoId);
    QObject::connect(videoReply,&User::Reply::readyRead,[=](){
        const auto document =  QJsonDocument::fromJson(videoReply->readAll());
        auto videoMap = document.object().value("document").toObject().toVariantMap();
        const auto comments = this->userComment(videoMap.value("comments").toJsonValue().toArray(),commentText);
        videoMap.insert("comments",comments);
        videoMap.remove("_id");
        const auto update = this->updateOneDocumentById(videoMap,videoId,"videos");
        const auto updateEndpoint = this->getMongoEndpoint(Endpoints::MongoEndpoints::updateOne);
        const auto updateReply = this->makeMongoPostRequest(updateEndpoint,update);
        this->connectPostVideoComment(updateReply,videoId);
        videoReply->deleteLater();
    });
}

QStringList User::favorites() const
{
    return this->_favorites;
}
