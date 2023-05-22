import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class FoodDetailController extends GetxController {
  FoodResponse? foodResponse;

  final RxInt _numFood = 1.obs;
  set numFood(int value) => _numFood.value = value;
  int get numFood => _numFood.value;

  late FoodDetailHttpService _foodDetailHttpService;
  RestaurantModel? restaurantModel;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _foodDetailHttpService = Get.find<FoodDetailHttpService>();
    if (Get.arguments != null && Get.arguments is FoodResponse) {
      foodResponse = Get.arguments as FoodResponse;
    }
    getRestaurantById().then((value) {
      if (value) {
        isLoading = true;
      }
    });
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
      final result = await _foodDetailHttpService
          .getRestaurantByID(foodResponse!.restaurantId!);
      if (result.isSuccess() && result.data != null) {
        restaurantModel = result.data;
      }
    } else {
      
    }
    return true;
  }
}
