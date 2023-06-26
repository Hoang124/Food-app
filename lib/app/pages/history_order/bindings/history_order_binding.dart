import 'package:foodapp/app/core.dart';

class HistoryOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryOrderController>(HistoryOrderController());
  }
}
