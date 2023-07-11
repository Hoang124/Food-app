import 'package:flutter/cupertino.dart';
import 'package:foodapp/app/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchController extends GetxController {
  final RxList<Widget> _filteredGridItems = <Widget>[].obs;
  set filteredGridItems(List<Widget> listGridView) =>
      _filteredGridItems.value = listGridView;
  // ignore: invalid_use_of_protected_member
  List<Widget> get filteredGridItems => _filteredGridItems.value;

  final TextEditingController textEditingController = TextEditingController();

  late FoodHttpService _foodHttpService;
  late AIService _aiService;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  Position? position;
  @override
  void onInit() {
    _aiService = Get.find<AIService>();
    _foodHttpService = Get.find<FoodHttpService>();
    if (Get.arguments != null && Get.arguments is String) {
      textEditingController.text = Get.arguments as String;
    }
    getRecommendFood().then((value) => {
          filteredGridItems = value
              .map((e) => const SearchView().searchItem(Get.context!, e))
              .toList(),
          isLoading = true,
          _filteredGridItems.refresh()
        });
    super.onInit();
  }

  Future<List<FoodResponse>> getRecommendFood() async {
    await getCurrentLocation();
    final result =
        await _aiService.getRecommendFoodSearch(Prefs.getInt(AppKeys.userID));
    // ignore: prefer_typing_uninitialized_variables
    final foodResult;
    // ignore: prefer_typing_uninitialized_variables
    final data;
    if (result.isSuccess() && result.data != null) {
      data = result.data['recommendFood'];
    } else {
      data = [];
    }
    foodResult =
        await _foodHttpService.getSearchFood(data, textEditingController.text);
    if (foodResult.isSuccess() && foodResult.data != null) {
      List<FoodResponse> listFood = foodResult.data as List<FoodResponse>;
      await HomeSubController().getCurrentLocation();
      for (FoodResponse food in listFood) {
        food.distance = caculateDistance(LatLng(
            double.tryParse(food.lat ?? "") ?? 0,
            double.tryParse(food.lng ?? "") ?? 0));
      }
      listFood.sort((a, b) => a.distance?.compareTo(b.distance ?? 0) ?? 0);
      return listFood;
    }
    return [];
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
    return true;
  }

  void search() {
    isLoading = false;
    getRecommendFood().then((value) => {
          filteredGridItems = value
              .map((e) => const SearchView().searchItem(Get.context!, e))
              .toList(),
          isLoading = true,
          _filteredGridItems.refresh()
        });
  }

  double caculateDistance(LatLng to) {
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
}
