import 'package:get/get.dart';
import 'add_controller.dart';

class AskQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AskQuestionController());
  }
}
