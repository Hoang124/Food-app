


import 'package:foodapp/app/core.dart';

class FeedbackBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<FeeadbackService>(FeeadbackService());
    Get.put(FeedbackController());
  }
}