import 'package:odoo/utils/import_export.dart';

class UserService{
    var users;

    UserService() {
      users = FirebaseFirestore.instance.collection('users');
    }
}
