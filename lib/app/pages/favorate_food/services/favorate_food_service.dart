import 'package:dio/dio.dart';
import 'package:foodapp/app/core.dart';

class FavorateFoodService extends BaseApiClient {
  Future<BaseResp<dynamic>> getFavorateFood(int id) async {
    return request<dynamic>(
      Method.get,
      AppApi.getFavorateFood,
      options: Options(headers: <String, dynamic>{
        'userId': id,
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

  Future<BaseResp<dynamic>> insert(int userId, int foodId) async {
    return request<dynamic>(
      Method.post,
      AppApi.saveFavorateFood,
      options: Options(headers: {
        "userId": userId,
        "foodId": foodId,
      }),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> delete(int userId, int foodId) async {
    return request<dynamic>(
      Method.delete,
      AppApi.deleteFavorateFood(foodId),
      options: Options(headers: {
        "userId": userId,
      }),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
