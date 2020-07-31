import 'package:get/get.dart';
import '../product_controller.dart';

class ProductBind extends Bindings {
  @override
  void dependencies() {
    //* Initialize permanent as true if you want to use anywhere in your Subtree
    Get.put<ProductController>(ProductController(), permanent: true);
  }
}
