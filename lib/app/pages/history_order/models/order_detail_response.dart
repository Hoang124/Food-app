import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_detail_response.g.dart';

@JsonSerializable()
class OrderDetailResponse {
  int? id;
  double? price;
  int? quantity;
  double? subTotal;
  FoodResponse? foodItemResponse;
  OrderDetailResponse({
    this.id,
    this.price,
    this.quantity,
    this.subTotal,
    this.foodItemResponse,
  });
  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}
