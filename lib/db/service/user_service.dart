import 'package:odoo/utils/import_export.dart';

class UserService{
    var _usersRef = FirebaseFirestore.instance.collection('users');

    void createUser(UserModule user){
        _usersRef.add(user.toJson());
    }

}
