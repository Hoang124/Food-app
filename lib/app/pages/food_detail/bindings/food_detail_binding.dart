import 'package:foodapp/app/core.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavorateFoodService());
    Get.put(RestaurantService());
    Get.put(FoodDetailController());
  }
}
