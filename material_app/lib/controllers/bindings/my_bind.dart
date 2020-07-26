import 'package:get/get.dart';
import '../my_controller.dart';

class MyBind extends Bindings {
  @override
  void dependencies() {
    //* Binding will be called only when the page is loaded.
    Get.lazyPut<MyController>(() => MyController());
  }
}
