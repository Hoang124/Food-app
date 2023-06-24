import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class StoreController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;
  int endPage = 4;
  Timer? autoNextTabSchedule;

  RestaurantModel? restaurantModel;

  late CartManager _cartManager;
  CartModel? _cartModel;

  List<FoodResponse>? _foodResponses;
  int? _cartQuantity;
  set cartQuantity(int? value) => _cartQuantity = value;
  // ignore: unnecessary_getters_setters
  int? get cartQuantity => _cartQuantity;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is RestaurantModel) {
      restaurantModel = Get.arguments as RestaurantModel;
    }

    _cartManager = Get.find<CartManager>();
    _cartModel = _cartManager.getCart();
    _foodResponses = _cartModel?.foodResponses;

    if (_foodResponses != null && _foodResponses!.isNotEmpty) {
      _cartQuantity = _foodResponses!.length;
    }
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void onReady() {
    super.onReady();
    _autoNextTabScheule();
  }

  @override
  void onClose() {
    cancelNextTabScheule();
    super.onClose();
  }

  void onPageChange(int index) {
    if (currentPage.value != index) {
      currentPage.value = index;
      _autoNextTabScheule();
    }
  }

  void onNextPage() {
    cancelNextTabScheule();
    if (currentPage.value < endPage) {
      _forceNextPage();
      _autoNextTabScheule();
    } else {
      // Get.offNamed<void>(Routes.signin);
    }
  }

  void _forceNextPage() {
    if (currentPage < endPage) {
      currentPage++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(
            milliseconds: AppProperties.defaultTransitionDuration),
        curve: Curves.ease,
      );
    }
  }

  void cancelNextTabScheule() {
    autoNextTabSchedule?.cancel();
  }

  void _autoNextTabScheule() async {
    cancelNextTabScheule();
    autoNextTabSchedule = Timer(const Duration(seconds: 2), () {
      if (currentPage < endPage) {
        _forceNextPage();
        _autoNextTabScheule();
      }
    });
  }
}
