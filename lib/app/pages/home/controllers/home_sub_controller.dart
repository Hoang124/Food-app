import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class HomeSubController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();
  TabController? tabController;
  final RxInt _indexTabBar = 0.obs;
  int get indexTabBar => _indexTabBar.value;
  set indexTabBar(int value) => _indexTabBar.value = value;
  @override
  void onInit() {
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
    super.onInit();
  }
}
