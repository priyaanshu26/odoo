import 'package:odoo/utils/import_export.dart';

class QueModule {
  int? _id;
  String? _title;
  String? _description;
  Map<String, dynamic>? _descriptionDelta;
  String? _descriptionText;
  List<String>? _tags;
  String? _author;
  List<String>? _answers;
  String? _acceptedAnswer;
  List<String>? _upVotes;
  List<String>? _downVotes;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  // Getters
  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  Map<String, dynamic>? get descriptionDelta => _descriptionDelta;
  String? get descriptionText => _descriptionText;
  List<String>? get tags => _tags;
  String? get author => _author;
  List<String>? get answers => _answers;
  String? get acceptedAnswer => _acceptedAnswer;
  List<String>? get upVotes => _upVotes;
  List<String>? get downVotes => _downVotes;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  // Setters
  set id(int? value) => _id = value;
  set title(String? value) => _title = value;
  set description(String? value) => _description = value;
  set descriptionDelta(Map<String, dynamic>? value) => _descriptionDelta = value;
  set descriptionText(String? value) => _descriptionText = value;
  set tags(List<String>? value) => _tags = value;
  set author(String? value) => _author = value;
  set answers(List<String>? value) => _answers = value;
  set acceptedAnswer(String? value) => _acceptedAnswer = value;
  set upVotes(List<String>? value) => _upVotes = value;
  set downVotes(List<String>? value) => _downVotes = value;
  set createdAt(DateTime? value) => _createdAt = value;
  set updatedAt(DateTime? value) => _updatedAt = value;

  QueModule({
    int? id,
    String? title,
    String? description,
    Map<String, dynamic>? descriptionDelta,
    String? descriptionText,
    List<String>? tags,
    String? author,
    List<String>? answers,
    String? acceptedAnswer,
    List<String>? upVotes,
    List<String>? downVotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _descriptionDelta = descriptionDelta;
    _descriptionText = descriptionText;
    _tags = tags;
    _author = author;
    _answers = answers;
    _acceptedAnswer = acceptedAnswer;
    _upVotes = upVotes;
    _downVotes = downVotes;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  static QueModule fromJson(Map<String, dynamic> json) {
    return QueModule(
      id: json[KEY_ID],
      title: json[KEY_TITLE],
      description: json[KEY_DESCRIPTION],
      descriptionDelta: json[KEY_DESCRIPTION_DELTA],
      descriptionText: json[KEY_DESCRIPTION_TEXT],
      tags: json[KEY_TAGS] != null ? List<String>.from(json[KEY_TAGS]) : null,
      author: json[KEY_AUTHOR],
      answers: json[KEY_ANSWERS] != null ? List<String>.from(json[KEY_ANSWERS]) : null,
      acceptedAnswer: json[KEY_ACCEPTED_ANSWER],
      upVotes: json[KEY_UP_VOTES] != null ? List<String>.from(json[KEY_UP_VOTES]) : null,
      downVotes: json[KEY_DOWN_VOTES] != null ? List<String>.from(json[KEY_DOWN_VOTES]) : null,
      createdAt: json[KEY_CREATED_AT] != null ? DateTime.parse(json[KEY_CREATED_AT]) : null,
      updatedAt: json[KEY_UPDATED_AT] != null ? DateTime.parse(json[KEY_UPDATED_AT]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_ID: _id,
      KEY_TITLE: _title,
      KEY_DESCRIPTION: _description,
      KEY_DESCRIPTION_DELTA: _descriptionDelta,
      KEY_DESCRIPTION_TEXT: _descriptionText,
      KEY_TAGS: _tags,
      KEY_AUTHOR: _author,
      KEY_ANSWERS: _answers,
      KEY_ACCEPTED_ANSWER: _acceptedAnswer,
      KEY_UP_VOTES: _upVotes,
      KEY_DOWN_VOTES: _downVotes,
      KEY_CREATED_AT: _createdAt?.toIso8601String(),
      KEY_UPDATED_AT: _updatedAt?.toIso8601String(),
    };
  }

  // Helper methods
  int get voteCount => (upVotes?.length ?? 0) - (downVotes?.length ?? 0);
  int get answerCount => answers?.length ?? 0;
  bool get hasAcceptedAnswer => acceptedAnswer != null;

  // Check if user has voted
  bool hasUserUpvoted(String userId) => upVotes?.contains(userId) ?? false;
  bool hasUserDownvoted(String userId) => downVotes?.contains(userId) ?? false;

  @override
  String toString() {
    return 'QueModule(id: $id, title: $title, tags: $tags, voteCount: $voteCount, answerCount: $answerCount)';
  }
}