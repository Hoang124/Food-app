import 'package:foodapp/app/core.dart';

class FoodHttpService extends BaseApiClient {
  Future<BaseResp<List<FoodResponse>>> getFoods(int pageNumber) async {
    return request<List<FoodResponse>>(
      Method.get,
      AppApi.getFood,
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
