import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeSubController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();
  TabController? tabController;
  final RxInt _indexTabBar = 0.obs;
  int get indexTabBar => _indexTabBar.value;
  set indexTabBar(int value) => _indexTabBar.value = value;
  late FoodHttpService _foodHttpService;
  late RestaurantService _restaurantService;
  late AIService _aiService;

  final RxList<FoodResponse> _listFood = <FoodResponse>[].obs;
  set listFood(List<FoodResponse> value) => _listFood.value = value;
  // ignore: invalid_use_of_protected_member
  List<FoodResponse> get listFood => _listFood.value;

  List<RestaurantModel>? restaurantList;
  Position? position;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final RxBool _isResLoading = false.obs;
  set isResLoading(bool value) => _isResLoading.value = value;
  bool get isResLoading => _isResLoading.value;

  final RxString _address = "".obs;
  set address(String value) => _address.value = value;
  String get address => _address.value;

  @override
  void onInit() {
    _aiService = Get.find<AIService>();
    _foodHttpService = Get.find<FoodHttpService>();
    _restaurantService = Get.find<RestaurantService>();
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
    getRecommendFood().then((value) => isLoading = true);
    getRestaurants().then((value) => isResLoading = true);
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
  }

  Future<bool> getMyPositionCurrent() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressFromCoordinates();
    return true;
  }

  Future<void> getRecommendFood() async {
    await getCurrentLocation();
    final result =
        await _aiService.getRecommendFood(Prefs.getInt(AppKeys.userID));
    // ignore: prefer_typing_uninitialized_variables
    final foodResult;
    if (result.isSuccess() && result.data != null) {
      foodResult =
          await _foodHttpService.getRecommedFood(result.data['recommendFood']);
      if (foodResult.isSuccess() && foodResult.data != null) {
        listFood = foodResult.data ?? [];
        getDistanceRestaurantToCurrentPositon();
      }
    } else {
      getFoods(2);
    }
  }

  void getDistanceRestaurantToCurrentPositon() {
    for (FoodResponse food in listFood) {
      food.distance = caculateDistance(LatLng(
          double.tryParse(food.lat ?? "") ?? 0,
          double.tryParse(food.lng ?? "") ?? 0));
    }
    listFood.sort((a, b) => a.distance?.compareTo(b.distance ?? 0) ?? 0);
  }

  double caculateDistance(LatLng to)  {
    if (position != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        position!.latitude,
        position!.longitude,
        to.latitude,
        to.longitude,
      );
      return distanceInMeters;
    }
    return 0;
  }

  String converDistance(double distance) {
    if (distance > 1000) {
      return "${distance.toInt() / 1000} km";
    }
    return "${distance.toInt()} m";
  }

  Future<void> getFoods(int pageNumber) async {
    final result = await _foodHttpService.getFoods(pageNumber);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data ?? [];
      getDistanceRestaurantToCurrentPositon();
    }
  }

  Future<void> getFoodByCategory(int id) async {
    final result = await _foodHttpService.getFoodByCategory(id, 1);
    if (result.isSuccess() && result.data != null) {
      listFood = result.data ?? [];
      getDistanceRestaurantToCurrentPositon();
    }
  }

  Future<void> getRestaurants() async {
    final result = await _restaurantService.getAllRestaurant(1, 10);
    if (result.isSuccess() && result.data != null) {
      restaurantList = result.data;
      if (restaurantList != null) {
        for (RestaurantModel restaurant in restaurantList!) {
          restaurant.distance = caculateDistance(LatLng(
              double.tryParse(restaurant.lat ?? "") ?? 0,
              double.tryParse(restaurant.lng ?? "") ?? 0));
        }
        restaurantList!
            .sort((a, b) => a.distance?.compareTo(b.distance ?? 0) ?? 0);
      }
    }
  }

  Future<void> getAddressFromCoordinates() async {
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
      Placemark placemark = placemarks.first;
      address =
          "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}";
    }
  }
}
