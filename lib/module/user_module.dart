import 'package:odoo/utils/import_export.dart';

class UserModule {
  int? _id;
  get id => _id;
  set id(value) => _id = value;
  String? _username;
  get username => _username;
  set username(value) => _username = value;
  String? _email;
  get email => _email;
  set email(value) => _email = value;
  String? _password;
  get password => _password;
  set password(value) => _password = value;
  String? _role;
  get role => _role;
  set role(value) => _role = value;
  bool? _banned;
  get banned => _banned;
  set banned(value) => _banned = value;
  List? _notifications;
  get notifications => _notifications;
  set notifications(value) => _notifications = value;
  DateTime? _createdAt;
  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  UserModule({
    int? id,
    String? username,
    String? email,
    String? password,
    String? role,
    bool? banned,
    List? notifications,
    DateTime? createdAt,
  }) {
    this._id = id;
    this._username = username;
    this._email = email;
    this._password = password;
    this._role = role;
    this._banned = banned;
    this._notifications = notifications;
    this._createdAt = createdAt;
  }

  static UserModule fromJson(Map<String, dynamic> json) {
    return UserModule(
      id: json[KEY_ID],
      username: json[KEY_USERNAME],
      email: json[KEY_EMAIL],
      password: json[KEY_PASSWORD],
      role: json[KEY_ROLE],
      banned: json[KEY_BANNED],
      notifications: json[KEY_NOTIFICATIONS],
      createdAt: json[KEY_CREATED_AT],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KEY_ID: _id,
      KEY_USERNAME: _username,
      KEY_EMAIL: _email,
      KEY_PASSWORD: _password,
      KEY_ROLE: _role,
      KEY_BANNED: _banned,
      KEY_NOTIFICATIONS: _notifications,
      KEY_CREATED_AT: _createdAt,
    };
  }
}
