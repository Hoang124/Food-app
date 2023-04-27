import 'package:foodapp/app/core.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FoodDetailController());
  }
}
