import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final RxInt _currentTab = 0.obs;
  set currentTab(int value) => _currentTab.value = value;
  int get currentTab => _currentTab.value;
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> screen = [
    const HomeSubView(),
    const FavorateView(),
    const NotificationView(),
    const SettingView(),
  ];

  late CartManager _cartManager;
  CartModel? _cartModel;

  List<FoodResponse>? _foodResponses;
  int? _cartQuantity;
  set cartQuantity(int? value) => _cartQuantity = value;
  // ignore: unnecessary_getters_setters
  int? get cartQuantity => _cartQuantity;

  Widget currentScreen = const HomeSubView();

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    _cartManager = Get.find<CartManager>();
    _cartModel = _cartManager.getCart();
    _foodResponses = _cartModel?.foodResponses;

    if (_foodResponses != null && _foodResponses!.isNotEmpty) {
      _cartQuantity = _foodResponses!.length;
    }
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      LogUtil.d('Home: on app ressume!');
    }
  }

  Widget getWidget() {
    return screen[currentTab];
  }
}
