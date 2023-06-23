import 'package:foodapp/app/core.dart';

class OrderService extends BaseApiClient {
  Future<BaseResp<dynamic>> order(OrderModel orderModel) async {
    return request<dynamic>(
      Method.post,
      AppApi.order,
      data: orderModel.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return LoginResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
