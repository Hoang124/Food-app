import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class FoodDetailController extends GetxController {
  FoodResponse? foodResponse;

  final RxInt _numFood = 1.obs;
  set numFood(int value) => _numFood.value = value;
  int get numFood => _numFood.value;

  late RestaurantService _restaurantService;
  RestaurantModel? restaurantModel;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  late CartManager _cartManager;
  List<FoodResponse> foodResponses = [];
  CartModel? _cartModel;

  final RxBool _isFavorite = false.obs;
  set isFavorite(bool value) => _isFavorite.value = value;
  bool get isFavorite => _isFavorite.value;

  late FavorateFoodService _favorateFoodService;

  @override
  void onInit() {
    _restaurantService = Get.find<RestaurantService>();
    if (Get.arguments != null && Get.arguments is FoodResponse) {
      foodResponse = Get.arguments as FoodResponse;
    }
    getRestaurantById().then((value) {
      if (value) {
        isLoading = true;
      }
    });

    _cartManager = Get.find<CartManager>();
    _cartModel = _cartManager.getCart();
    if (_cartModel != null && _cartModel!.foodResponses != null) {
      foodResponses = _cartModel!.foodResponses!;
    }

    if (foodResponse != null) {
      isFavorite = foodResponse!.isFavorite!;
    }

    _favorateFoodService = Get.find<FavorateFoodService>();

    super.onInit();
  }

  void plusFood() {
    numFood += 1;
  }

  void minusFood() {
    if (numFood > 1) {
      numFood -= 1;
    }
  }

  bool addFoodToCart() {
    int quantity = numFood;
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (foodResponse != null) {
      FoodResponse? food = foodResponses
          .firstWhereOrNull((element) => foodResponse!.id == element.id);
      if (food != null) {
        if (food.quantity != null) {
          food.quantity = food.quantity! + quantity;
        } else {
          food.quantity = quantity;
        }
      } else {
        foodResponse!.quantity = quantity;
        foodResponses.add(foodResponse!);
      }
      if (_cartModel != null) {
        _cartModel!.foodResponses = foodResponses;
        _cartManager.saveCart(_cartModel);
      } else {
        int userId = Prefs.getInt(AppKeys.userID);
        _cartModel = CartModel(
          foodResponses: foodResponses,
          idUser: userId,
        );
        _cartManager.saveCart(_cartModel);
      }
      numFood = 1;
    }
    processingDialog.hide();
    return true;
  }

  String getMomey() {
    if (foodResponse != null && foodResponse!.price != null) {
      return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
          .format(foodResponse!.price! * numFood);
    } else {
      return "0";
    }
  }

  Future<bool> getRestaurantById() async {
    if (foodResponse != null && foodResponse!.restaurantId != null) {
      final result = await _restaurantService
          .getRestaurantByID(foodResponse!.restaurantId!);
      if (result.isSuccess() && result.data != null) {
        restaurantModel = result.data;
      }
    } else {}
    return true;
  }

  Future<void> insertFavoriteFood(int userId, int foodId) async {
    final result = await _favorateFoodService.insert(userId, foodId);
    if (result.isSuccess()) {
      isFavorite = true;
      _isFavorite.refresh();
    }
  }

  Future<void> deleteFavoriteFood(int userId, int foodId) async {
    final result = await _favorateFoodService.delete(userId, foodId);
    if (result.isSuccess()) {
      isFavorite = false;
      _isFavorite.refresh();
    }
  }
}
