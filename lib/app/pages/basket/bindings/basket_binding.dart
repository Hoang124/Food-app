import 'package:foodapp/app/core.dart';

class BasketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BasketController());
  }
}
