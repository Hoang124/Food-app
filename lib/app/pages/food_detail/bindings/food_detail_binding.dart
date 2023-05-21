import 'package:foodapp/app/core.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FoodDetailHttpService());
    Get.put(FoodDetailController());
  }
}
