import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String _title;
  String _previewContent;
  String _content;
  String _url;
  int _likeCount;
  int _commentCount;
  bool _isImage;
  Map _comments;


  Post(this._title, this._previewContent, this._content, this._url, this._likeCount,
      this._commentCount, this._isImage, this._comments);

  factory Post.fromDocument(DocumentSnapshot doc){
    return Post(doc['title'], doc['previewContent'], doc['content'], doc['url'], doc['likeCount'], doc['commentCount'], doc['isImage'], doc['comments']);
  }

  Map get comments => _comments;

  bool get isImage => _isImage;

  int get commentCount => _commentCount;

  int get likeCount => _likeCount;

  String get url => _url;

  String get content => _content;

  String get previewContent => _previewContent;

  String get title => _title;
}
