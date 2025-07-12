import 'package:odoo/utils/import_export.dart';

class UserService{
    final users = await FirebaseFirestore.instance.collection('users');
}
