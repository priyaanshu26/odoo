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

  QueModule({
    int? id,
    String? title,
    String? description,
    List? tags,
    String? author,
    List? answers,
    String? acceptedAnswer,
    List? upVotes,
    List? downVotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._tags = tags;
    this._author = author;
    this._answers = answers;
    this._acceptedAnswer = acceptedAnswer;
    this._upVotes = upVote;
    this._downVotes = downVote;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  static QueModule fromJson(Map<String, dynamic> json) {
    return QueModule(
      id: json[KEY_ID],
      title: json[KEY_TITLE],
      description: json[KEY_DESCRIPTION],
      tags: json[KEY_TAGS],
      author: json[KEY_AUTHOR],
      answers: json[KEY_ANSWERS],
      acceptedAnswer: json[KEY_ACCEPTED_ANSWER],
      upVotes: json[KEY_UP_VOTES],
      downVotes: json[KEY_DOWN_VOTES],
      createdAt: json[KEY_CREATED_AT],
      updatedAt: json[KEY_UPDATED_AT],
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
      KEY_UP_VOTES: _upVotes,
      KEY_DOWN_VOTES: _downVotes,
      KEY_CREATED_AT: _createdAt,
      KEY_UPDATED_AT: _updatedAt,
    };
  }
}
