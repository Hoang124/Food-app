import 'package:dio/dio.dart';
import 'package:foodapp/app/core.dart';

class FoodHttpService extends BaseApiClient {
  Future<BaseResp<List<FoodResponse>>> getFoods(int pageNumber) async {
    return request<List<FoodResponse>>(
      Method.get,
      AppApi.getFood(10, pageNumber),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => FoodResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<FoodResponse>>> getRecommedFood(
      List<dynamic> recommendFood) async {
    return request<List<FoodResponse>>(
      Method.get,
      AppApi.getRecommendFood,
      // data: jsonEncode(recommendFood),
      options: Options(headers: {
        'recommendFood': recommendFood,
      }),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => FoodResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<FoodResponse>>> getSearchFood(
      List<dynamic> recommendFood, String search) async {
    return request<List<FoodResponse>>(
      Method.get,
      AppApi.getSearchFood,
      queryParameters: {
        "search": search,
      },
      // data: jsonEncode(recommendFood),
      options: Options(headers: {
        'recommendFood': recommendFood,
      }),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => FoodResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<FoodResponse>>> getFoodByCategory(
    int categoryId,
    int pageNumber,
  ) async {
    return request<List<FoodResponse>>(
      Method.get,
      AppApi.getFoodByCategory(categoryId),
      queryParameters: {
        "pageNumber": pageNumber,
        "pageSize": 10,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => FoodResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
