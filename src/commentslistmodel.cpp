#include "commentslistmodel.hpp"

CommentsListModel::CommentsListModel(QAbstractListModel *parent)
    : QAbstractListModel{parent}
{

}

int CommentsListModel::rowCount(const QModelIndex &index) const
{
    if (index.isValid() || this->_comments.isEmpty()) { return 0; }
    else return this->_comments.size();
}

QVariant CommentsListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || this->_comments.isEmpty()) { return QVariant(); }
    const auto comment = this->_comments.at(index.row());

    switch (role){
    case CommentRole:
        return comment.toVariant().toString();
    case EmailRole:
        return comment.toVariant().toString();
    case PublishedRole:
        return comment.toVariant().toString();
    default:
        return QVariant();
    }
}

Qt::ItemFlags CommentsListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid()) { return Qt::NoItemFlags; }
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> CommentsListModel::roleNames() const
{
    const QHash<int, QByteArray> names = {
        {CommentRole,"comment"},
        {EmailRole,"email"},
        {PublishedRole,"published"},
    };
    return names;
}

QJsonArray CommentsListModel::allComments()
{
    return this->_comments;
}

void CommentsListModel::setAllComments(const QJsonArray& comments)
{
    qDebug() << "Setting comments";
    if (this->_comments != comments){
        this->beginResetModel();
        this->_comments = comments;
        this->endResetModel();
        emit CommentsListModel::allCommentsChanged();
    }
}


