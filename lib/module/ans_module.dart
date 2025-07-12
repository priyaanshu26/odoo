import 'package:odoo/utils/import_export.dart';

class AnsModule {
  int? _id;
  get id => _id;
  set id(value) => _id = value;
  String? _content;
  get content => _content;
  set content(value) => _content = value;
  String? _que;
  get que => _que;
  set que(value) => _que = value;
  String? _author;
  get author => _author;
  set author(value) => _author = value;
  List? _upVotes;
  get upVotes => _upVotes;
  set upVotes(value) => _upVotes = value;
  List? _downVotes;
  get downVotes => _downVotes;
  set downVotes(value) => _downVotes = value;
  DateTime? _createdAt;
  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;
  DateTime? _updatedAt;
  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;

  AnsModule({
    int? id,
    String? content,
    String? que,
    String? author,
    List? upVotes,
    List? downVotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    this._id = id;
    this._content = content;
    this._que = que;
    this._author = author;
    this._upVotes = upVotes;
    this._downVotes = downVotes;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  static AnsModule fromJson(Map<String, dynamic> json) {
    return AnsModule(
      id: json[KEY_ID],
      content: json[KEY_CONTENT],
      que: json[KEY_QUE],
      author: json[KEY_AUTHOR],
      upVotes: json[KEY_UP_VOTES],
      downVotes: json[KEY_DOWN_VOTES],
      createdAt: json[KEY_CREATED_AT],
      updatedAt: json[KEY_UPDATED_AT],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_ID: _id,
      KEY_CONTENT: _content,
      KEY_QUE: _que,
      KEY_AUTHOR: _author,
      KEY_UP_VOTES: _upVotes,
      KEY_DOWN_VOTES: _downVotes,
      KEY_CREATED_AT: _createdAt,
      KEY_UPDATED_AT: _updatedAt,
    };
  }
}