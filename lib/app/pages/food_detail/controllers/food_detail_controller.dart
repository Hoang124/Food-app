import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class FoodDetailController extends GetxController {
  Rx<FoodResponse> _foodResponse = Rx<FoodResponse>(FoodResponse());
  set foodResponse(FoodResponse value) => _foodResponse.value = value;
  FoodResponse get foodResponse => _foodResponse.value;

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

    isFavorite = foodResponse.isFavorite ?? false;

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

  void changeFoodResponse(FoodResponse foodRe) {
    foodResponse = foodRe;
    numFood = 1;
    isFavorite = foodRe.isFavorite!;
  }

  void addFoodToCart() {
    int quantity = numFood;
    bool check = false;
    // ProcessingDialog processingDialog = ProcessingDialog.show();
    FoodResponse? food = foodResponses
        .firstWhereOrNull((element) => foodResponse.id == element.id);
    if (food != null) {
      if (food.quantity != null) {
        food.quantity = food.quantity! + quantity;
      } else {
        food.quantity = quantity;
      }
      saveFoodResponses();
    } else {
      if (foodResponses.isNotEmpty) {
        if (foodResponses[0].restaurantId != foodResponse.restaurantId) {
          String message =
              "You are adding another restaurant's dish. Do you want to delete the old restaurant's dishes?";
          confirmStopRent(
              Get.context!, message, handleConfirmAddFoodDifferentRestaurant);
        }
      }
    }
    // processingDialog.hide();
  }

  void saveFoodResponses() {
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
    Get.toNamed(Routes.cart);
  }

  String getMomey() {
    if (foodResponse.price != null) {
      return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
          .format(foodResponse.price! * numFood);
    } else {
      return "0";
    }
  }

  Future<bool> getRestaurantById() async {
    if (foodResponse.restaurantId != null) {
      final result = await _restaurantService
          .getRestaurantByID(foodResponse.restaurantId!);
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

  void handleConfirmAddFoodDifferentRestaurant() {
    foodResponses = [];
    foodResponse.quantity = numFood;
    foodResponses.add(foodResponse);
    Navigator.of(Get.context!).pop();
    saveFoodResponses();
  }

// Confirm dialog
  void confirmStopRent(
    BuildContext context,
    String message,
    Function? handle,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          message,
                          style: AppTextStyles.body1().copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {
                            if (handle != null) {
                              handle.call();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          style: OutlineButtonStyle.enable(
                              isFullWidth: true,
                              outlineColor: AppColors.primaryColor),
                          child: Text(
                            S.of(context).confirm,
                            style: AppTextStyles.body2().copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
