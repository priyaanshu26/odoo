import 'package:odoo/utils/import_export.dart';

class QueModule {
  int? _id;
  get id => _id;
  set id(value) => _id = value;
  String? _title;
  get title => _title;
  set title(value) => _title = value;
  String? _description;
  get description => _description;
  set description(value) => _description = value;
  List? _tags;
  get tags => _tags;
  set tags(value) => _tags = value;
  String? _author;
  get author => _author;
  set author(value) => _author = value;
  List? _answers;
  get answers => _answers;
  set answers(value) => _answers = value;
  String? _acceptedAnswer;
  get acceptedAnswer => _acceptedAnswer;
  set acceptedAnswer(value) => _acceptedAnswer = value;
  List? _votes;
  get votes => _votes;
  set votes(value) => _votes = value;
  DateTime? _createdAt;
  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;
  DateTime? _updatedAt;
  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;


  QueModule(int id, String title, String description, List tags, String author, List answers, String acceptedAnswer, List votes, DateTime createdAt, DateTime updatedAt,){
    this._id = id;
    this._title = title;
    this._description = description;
    this._tags = tags;
    this._author = author;
    this._answers = answers;
    this._acceptedAnswer = acceptedAnswer;
    this._votes = votes;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  static QueModule fromJson(Map<String, dynamic> json) {
    return QueModule(
      json[KEY_ID],
      json[KEY_TITLE],
      json[KEY_DESCRIPTION],
      json[KEY_TAGS],
      json[KEY_AUTHOR],
      json[KEY_ANSWERS],
      json[KEY_ACCEPTED_ANSWER],
      json[KEY_VOTES],
      json[KEY_CREATED_AT],
      json[KEY_UPDATED_AT],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_ID: _id,
      KEY_TITLE: _title,
      KEY_DESCRIPTION: _description,
      KEY_TAGS: _tags,
      KEY_AUTHOR: _author,
      KEY_ANSWERS: _answers,
      KEY_ACCEPTED_ANSWER: _acceptedAnswer,
      KEY_VOTES: _votes,
      KEY_CREATED_AT: _createdAt,
      KEY_UPDATED_AT: _updatedAt,
    };
  }

}
