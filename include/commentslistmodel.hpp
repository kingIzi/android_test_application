#pragma once

#include <QObject>
#include <QAbstractListModel>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>

class CommentsListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray allComments READ allComments WRITE setAllComments NOTIFY allCommentsChanged);
private:
    QJsonArray _comments = {};
public:
    explicit CommentsListModel(QAbstractListModel *parent = nullptr);
    enum{
        CommentRole = Qt::UserRole,
        EmailRole,
        PublishedRole,
    };
    int rowCount(const QModelIndex& index = QModelIndex()) const override;
    QVariant data(const QModelIndex& index,int role = Qt::DisplayRole) const override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int,QByteArray> roleNames() const override;
    QJsonArray allComments();
public slots:
    void setAllComments(const QJsonArray& comments);
signals:
    void allCommentsChanged();
};

