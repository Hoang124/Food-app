import 'package:foodapp/app/core.dart';
import 'package:foodapp/app/pages/cart/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
