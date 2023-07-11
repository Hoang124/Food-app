import 'package:flutter/cupertino.dart';
import 'package:foodapp/app/core.dart';

class SearchController extends GetxController {
  final RxList<Widget> _filteredGridItems = <Widget>[].obs;
  set filteredGridItems(List<Widget> listGridView) =>
      _filteredGridItems.value = listGridView;
  // ignore: invalid_use_of_protected_member
  List<Widget> get filteredGridItems => _filteredGridItems.value;

  final TextEditingController textEditingController = TextEditingController();

  late FoodHttpService _foodHttpService;
  late AIService _aiService;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _aiService = Get.find<AIService>();
    _foodHttpService = Get.find<FoodHttpService>();
    if (Get.arguments != null && Get.arguments is String) {
      textEditingController.text = Get.arguments as String;
    }
    getRecommendFood().then((value) => {
          filteredGridItems = value
              .map((e) => const SearchView().searchItem(Get.context!, e))
              .toList(),
          isLoading = true,
          _filteredGridItems.refresh()
        });
    super.onInit();
  }

  Future<List<FoodResponse>> getRecommendFood() async {
    final result =
        await _aiService.getRecommendFoodSearch(Prefs.getInt(AppKeys.userID));
    final foodResult;
    final data;
    if (result.isSuccess() && result != null) {
      data = result.data['recommendFood'];
    } else {
      data = [];
    }
    foodResult =
        await _foodHttpService.getSearchFood(data, textEditingController.text);
    if (foodResult.isSuccess() && foodResult.data != null) {
      return foodResult.data;
    }
    return [];
  }

  void search() {
    isLoading = false;
    getRecommendFood().then((value) => {
          filteredGridItems = value
              .map((e) => const SearchView().searchItem(Get.context!, e))
              .toList(),
          isLoading = true,
          _filteredGridItems.refresh()
        });
  }
}
