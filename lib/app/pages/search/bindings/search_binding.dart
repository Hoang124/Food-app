import 'package:foodapp/app/core.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AIService());
    Get.put<FoodHttpService>(FoodHttpService());
    Get.put<SearchController>(SearchController());
  }
}
