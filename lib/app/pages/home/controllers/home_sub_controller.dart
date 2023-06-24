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
  List<FoodResponse>? listFood;
  List<RestaurantModel>? restaurantList;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final RxBool _isResLoading = false.obs;
  set isResLoading(bool value) => _isResLoading.value = value;
  bool get isResLoading => _isResLoading.value;

  @override
  void onInit() {
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
    getFoods().then((value) => isLoading = true);
    getRestaurants().then((value) => isResLoading = true);
    super.onInit();
  }

  Future<void> getFoods() async {
    final result = await _foodHttpService.getFoods(1);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data;
    }
  }

  Future<void> getRestaurants() async {
    final result = await _restaurantService.getAllRestaurant(1, 10);
    if (result.isSuccess() && result.data != null) {
      restaurantList = result.data;
    }
  }
}
