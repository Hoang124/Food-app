import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class HomeSubController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();
  TabController? tabController;
  final RxInt _indexTabBar = 0.obs;
  int get indexTabBar => _indexTabBar.value;
  set indexTabBar(int value) => _indexTabBar.value = value;
  late FoodHttpService _foodHttpService;
  late RestaurantService _restaurantService;
  late AIService _aiService;

  final RxList<FoodResponse> _listFood = <FoodResponse>[].obs;
  set listFood(List<FoodResponse> value) => _listFood.value = value;
  // ignore: invalid_use_of_protected_member
  List<FoodResponse> get listFood => _listFood.value;

  List<RestaurantModel>? restaurantList;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final RxBool _isResLoading = false.obs;
  set isResLoading(bool value) => _isResLoading.value = value;
  bool get isResLoading => _isResLoading.value;

  @override
  void onInit() {
    _aiService = Get.find<AIService>();
    _foodHttpService = Get.find<FoodHttpService>();
    _restaurantService = Get.find<RestaurantService>();
    tabController = TabController(length: 5, vsync: this)
      ..addListener(
        () {
          if (tabController != null) {
            indexTabBar = tabController!.index;
          } else {
            indexTabBar = 0;
          }
        },
      );
    getRecommendFood().then((value) => isLoading = true);
    getRestaurants().then((value) => isResLoading = true);
    super.onInit();
  }

  Future<void> getRecommendFood() async {
    final result =
        await _aiService.getRecommendFood(Prefs.getInt(AppKeys.userID));
    final foodResult;
    if (result.isSuccess() && result.data != null) {
      foodResult =
          await _foodHttpService.getRecommedFood(result.data['recommendFood']);
      if (foodResult.isSuccess() && foodResult.data != null) {
        listFood = foodResult.data ?? [];
      }
    } else {
      getFoods(2);
    }
  }

  Future<void> getFoods(int pageNumber) async {
    final result = await _foodHttpService.getFoods(pageNumber);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data ?? [];
    }
  }

  Future<void> getFoodByCategory(int id) async {
    final result = await _foodHttpService.getFoodByCategory(id, 1);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data ?? [];
    }
  }

  Future<void> getRestaurants() async {
    final result = await _restaurantService.getAllRestaurant(1, 10);
    if (result.isSuccess() && result.data != null) {
      restaurantList = result.data;
    }
  }
}
