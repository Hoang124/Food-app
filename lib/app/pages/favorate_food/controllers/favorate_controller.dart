import 'package:foodapp/app/core.dart';

class FavorateController extends GetxController {
  late FavorateFoodService _favorateFoodService;

  final RxList<FoodResponse> _faFood = RxList<FoodResponse>();

  set faFood(List<FoodResponse> value) => _faFood.value = value;
  // ignore: invalid_use_of_protected_member
  List<FoodResponse> get faFood => _faFood.value;

  @override
  void onInit() {
    _favorateFoodService = Get.find<FavorateFoodService>();
    getFoods(Prefs.getInt(AppKeys.userID));
    super.onInit();
  }

  Future<void> getFoods(int id) async {
    final result = await _favorateFoodService.getFavorateFood(id);
    if (result.isSuccess() && result.data != null) {
      faFood = result.data;
    }
  }
}
