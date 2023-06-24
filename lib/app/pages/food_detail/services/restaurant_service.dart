import 'package:foodapp/app/core.dart';

class RestaurantService extends BaseApiClient {
  Future<BaseResp<RestaurantModel>> getRestaurantByID(int id) async {
    return request<RestaurantModel>(
      Method.get,
      AppApi.getRestaurantById(id),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return RestaurantModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<RestaurantModel>>> getAllRestaurant(
    int pageNumber,
    int pageSize,
  ) async {
    return request<List<RestaurantModel>>(
      Method.get,
      AppApi.getAllRestaurant,
      queryParameters: {"pageNumber": pageNumber, "pageSize": pageSize},
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
