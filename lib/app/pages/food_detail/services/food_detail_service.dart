import 'package:foodapp/app/core.dart';

class FoodDetailHttpService extends BaseApiClient {
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
}
