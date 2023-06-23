import 'package:flutter/cupertino.dart';
import 'package:foodapp/app/constants/constants.dart';
import 'package:foodapp/app/core.dart';

class CartController extends GetxController {
  late CartManager _cartManager;
  CartModel? _cartModel;

  final RxList<FoodResponse> _foodResponses = RxList<FoodResponse>();
  set foodResponses(List<FoodResponse> value) => _foodResponses.value = value;
  // ignore: invalid_use_of_protected_member
  List<FoodResponse> get foodResponses => _foodResponses.value;

  late StripeService _stripeService;
  // set stripeService(StripeService value) => _stripeService = value;
  // StripeService get stripeService => _stripeService;

  final RxDouble _totalPrice = 0.0.obs;
  set totalPrice(double value) => _totalPrice.value = value;
  double get totalPrice => _totalPrice.value;

  // double _deliveryFee = 20000;
  // double _totalPriceDelivery = 0;

  late OrderService _orderService;

  TextEditingController addAddress = TextEditingController();

  @override
  void onInit() {
    _cartManager = Get.find<CartManager>();
    _cartModel = _cartManager.getCart();
    foodResponses = _cartModel?.foodResponses ?? [];
    if (foodResponses.isNotEmpty) {
      calcTotalPrice();
    }
    _stripeService = Get.find<StripeService>();
    _orderService = Get.find<OrderService>();
    super.onInit();
  }

  void plusQuantity(int id) {
    FoodResponse? foodResponse =
        foodResponses.firstWhereOrNull((foodRes) => foodRes.id == id);
    if (foodResponse != null) {
      if (foodResponse.quantity != null) {
        foodResponse.quantity = foodResponse.quantity! + 1;
      } else {
        foodResponse.quantity = 1;
      }
    }
    _cartModel?.foodResponses = _foodResponses;
    _cartManager.saveCart(_cartModel);
    calcTotalPrice();
    _foodResponses.refresh();
  }

  void minusQuantity(int id) {
    FoodResponse? foodResponse =
        foodResponses.firstWhereOrNull((foodRes) => foodRes.id == id);
    if (foodResponse != null) {
      if (foodResponse.quantity != null && foodResponse.quantity! > 1) {
        foodResponse.quantity = foodResponse.quantity! - 1;
      } else {
        foodResponse.quantity = 1;
      }
    }
    _cartModel?.foodResponses = _foodResponses;
    _cartManager.saveCart(_cartModel);
    if (foodResponses.isNotEmpty) {
      calcTotalPrice();
    }
    _foodResponses.refresh();
  }

  Future<void> payment() async {
    try {
      try {
        await _stripeService.payment(
            Prefs.getInt(AppKeys.userID).toString(), totalPrice.toInt());
      } catch (e) {}
      List<OrderDetailModel> orderDetailList = foodResponses
          .map((foodRes) => OrderDetailModel(
              foodId: foodRes.id,
              price: foodRes.price,
              quantity: foodRes.quantity))
          .toList();
      OrderModel orderModel = OrderModel(
        address: addAddress.text,
        discount: 0,
        paymentMethod: null,
        restaurantId: foodResponses[0].restaurantId,
        totalPrice: totalPrice,
        orderDetailList: orderDetailList,
      );
      FoodOrder(orderModel);
    } catch (e) {}
  }

  void calcTotalPrice() {
    totalPrice = foodResponses
        .map((e) => e.price! * e.quantity!)
        .reduce((value, element) => value + element);
  }

  Future<void> FoodOrder(OrderModel orderModel) async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res = await _orderService.order(orderModel);
    if (res.isSuccess()) {
      processingDialog.hide();
      _cartManager.deleteCart();
      Get.offAllNamed(Routes.home);
    } else {
      processingDialog.hide();
    }
  }

  void deleteCart(int id) {
    foodResponses.removeWhere((element) => element.id == id);
    if (foodResponses.isNotEmpty) {
      calcTotalPrice();
    }
    _foodResponses.refresh();
  }
}
