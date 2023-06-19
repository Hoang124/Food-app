import 'package:foodapp/app/core.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommentHttpService());
    Get.put(CommentController());
  }
}
