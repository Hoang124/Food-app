import 'package:foodapp/app/core.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AIService());
    Get.put<FoodHttpService>(FoodHttpService());
    Get.put(RestaurantService());
    Get.put<HomeController>(HomeController());
    Get.put<HomeSubController>(HomeSubController());
    Get.put<NotificationController>(NotificationController());
    Get.put<SettingController>(SettingController());
    Get.put<FavorateFoodService>(FavorateFoodService());
    Get.put<FavorateController>(FavorateController());
  }
}
