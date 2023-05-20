import 'package:foodapp/app/core.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<HomeSubController>(HomeSubController());
    Get.put<NotificationController>(NotificationController());
    Get.put<SettingController>(SettingController());
    Get.put<FavorateController>(FavorateController());
  }
}
