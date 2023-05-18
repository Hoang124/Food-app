import 'package:foodapp/app/core.dart';

class FavorateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavorateController());
  }
}
