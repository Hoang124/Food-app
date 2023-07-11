import 'package:foodapp/app/core.dart';

class UserOrderService extends BaseApiClient {
  Future<BaseResp<List<OrderResponse>>> getUserOrder(
    int pageNumber,
    int pageSize,
  ) async {
    return request<List<OrderResponse>>(
      Method.get,
      AppApi.getUserOrder,
      queryParameters: {"pageNumber": pageNumber, "pageSize": pageSize},
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => OrderResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
