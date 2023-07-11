import 'package:foodapp/app/core.dart';

class AIService extends BaseApiClient {
  Future<BaseResp<dynamic>> getRecommendFood(int userId) async {
    return request<dynamic>(
      Method.get,
      AppApi.getRecommendFoodId(userId, 20),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> getRecommendFoodSearch(int userId) async {
    return request<dynamic>(
      Method.get,
      AppApi.getRecommendFoodIdSearch(userId),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
