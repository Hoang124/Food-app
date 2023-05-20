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
  List<FoodResponse>? listFood;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _foodHttpService = Get.find<FoodHttpService>();
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
    getFoods().then((value) => isLoading=true);
    super.onInit();
  }

  Future<void> getFoods() async {
    final result = await _foodHttpService.getFoods(1);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data;
    }
  }
}
