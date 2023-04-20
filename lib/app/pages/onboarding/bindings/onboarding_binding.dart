import 'package:foodapp/app/core.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      OnboardingController(),
    );
  }
}
