import 'package:foodapp/app/core.dart';

class CartController extends GetxController {
  late CartManager _cartManager;
  CartModel? _cartModel;

  final RxList<FoodResponse> _foodResponses = RxList<FoodResponse>();
  set foodResponses(List<FoodResponse> value) => _foodResponses.value = value;
  // ignore: invalid_use_of_protected_member
  List<FoodResponse> get foodResponses => _foodResponses.value;

  @override
  void onInit() {
    _cartManager = Get.find<CartManager>();
    _cartModel = _cartManager.getCart();
    foodResponses = _cartModel?.foodResponses ?? [];
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
    _foodResponses.refresh();
  }
}
