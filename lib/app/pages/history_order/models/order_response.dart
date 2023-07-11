import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  int? id;
  int? restaurantId;
  String? restaurantName;
  String? address;
  int? discount;
  String? phoneNumber;
  String? paymentMethod;
  int? receiveTime;
  double? totalPrice;
  String? image;
  List<OrderDetailResponse>? orderDetailList;
  OrderResponse({
    this.id,
    this.restaurantId,
    this.restaurantName,
    this.address,
    this.discount,
    this.phoneNumber,
    this.paymentMethod,
    this.receiveTime,
    this.totalPrice,
    this.image,
    this.orderDetailList,
  });
  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
