import 'package:get/get.dart';
import '../module/user_module.dart';

class UserController extends GetxController{
  final RxList<UserModule> _users = <UserModule>[].obs;

  get users => _users;

  Future<void> fetchData() async{
    // _users.value =
  }

  Future<void> addUser() async{

  }

  Future<void> deleteUser() async{

  }

}