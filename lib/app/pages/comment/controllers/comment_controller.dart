import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class CommentController extends GetxController {
  int? foodId;

  late CommentHttpService _commentHttpService;

  List<CommentModel> _commentModels = [];

  List<CommentModel> get commentModels => _commentModels;

  set commentModels(List<CommentModel> value) {
    _commentModels = value;
    update();
  }

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _commentHttpService = Get.find<CommentHttpService>();
    if (Get.arguments != null && Get.arguments is int) {
      foodId = Get.arguments as int;
    }
    getCommentByFoodId(foodId ?? 0).then((value) => {
          if (value) {isLoading = true}
        });
    super.onInit();
  }

  String convertDateTime(int? createAt) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createAt ?? 0);
    return DateFormat("MMM dd, yyyy").format(date);
  }

  Future<bool> getCommentByFoodId(int foodId) async {
    BaseResp<List<CommentModel>> response =
        await _commentHttpService.getCommentByFoodId(foodId);
    if (response.isSuccess() && response.data != null) {
      _commentModels = response.data ?? [];
      return true;
    } else {
      return false;
    }
  }
}
