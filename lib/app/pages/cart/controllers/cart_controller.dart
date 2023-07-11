import 'package:flutter/cupertino.dart';
import 'package:foodapp/app/core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  Position? position;
  final RxnString _myAddress = RxnString();
  set myAddress(String value) => _myAddress.value = value;
  String? get getMyAddress => _myAddress.value;

  final RxBool _isEnable = false.obs;
  set isEnable(bool value) => _isEnable.value = value;
  bool? get getIsEnable => _isEnable.value;

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

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Người dùng từ chối cho phép truy cập vị trí
        // Hiển thị thông báo yêu cầu quyền truy cập vị trí
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getMyPositionCurrent();
      // Xử lý dữ liệu vị trí
    }
    isEnable = addAddress.text.isNotEmpty;
  }

  Future<bool> getMyPositionCurrent() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressFromCoordinates();
    return true;
  }

  Future<void> getAddressFromCoordinates() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
      Placemark placemark = placemarks.first;

      String address = '';

      address =
          "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.country}";
      addAddress.text = address;
      isEnable = addAddress.text.isNotEmpty;
    }
    processingDialog.hide();
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
        List<OrderDetailModel> orderDetailList = foodResponses
            .map((foodRes) => OrderDetailModel(
                foodId: foodRes.id,
                price: foodRes.price,
                quantity: foodRes.quantity ?? 1))
            .toList();
        OrderModel orderModel = OrderModel(
          address: addAddress.text,
          discount: 0,
          paymentMethod: null,
          restaurantId: foodResponses[0].restaurantId,
          totalPrice: totalPrice,
          orderDetailList: orderDetailList,
        );
        foodOrder(orderModel);
        // ignore: empty_catches
      } catch (e) {}

      // ignore: empty_catches
    } catch (e) {}
  }

  void calcTotalPrice() {
    totalPrice = foodResponses
        .map((e) => e.price! * e.quantity!)
        .reduce((value, element) => value + element);
  }

  Future<void> foodOrder(OrderModel orderModel) async {
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
      _cartModel!.foodResponses = foodResponses;
      _cartManager.saveCart(_cartModel);
    } else {
      _cartManager.deleteCart();
    }
    _foodResponses.refresh();
  }
}
