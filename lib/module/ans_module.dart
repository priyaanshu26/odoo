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
  List? _votes;
  get votes => _votes;
  set votes(value) => _votes = value;
  DateTime? _createdAt;
  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;
  DateTime? _updatedAt;
  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;

  AnsModule(int id, String content, String que, String author, List votes, DateTime createdAt, DateTime updatedAt,){
    this._id = id;
    this._content = content;
    this._que = que;
    this._author = author;
    this._votes = votes;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  static AnsModule fromJson(Map<String, dynamic> json) {
    return AnsModule(
      json[KEY_ID],
      json[KEY_CONTENT],
      json[KEY_QUE],
      json[KEY_AUTHOR],
      json[KEY_VOTES],
      json[KEY_CREATED_AT],
      json[KEY_UPDATED_AT],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_ID: _id,
      KEY_CONTENT: _content,
      KEY_QUE: _que,
      KEY_AUTHOR: _author,
      KEY_VOTES: _votes,
      KEY_CREATED_AT: _createdAt,
      KEY_UPDATED_AT: _updatedAt,
    };
  }
}