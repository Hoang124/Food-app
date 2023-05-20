import 'package:foodapp/app/core.dart';


class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
