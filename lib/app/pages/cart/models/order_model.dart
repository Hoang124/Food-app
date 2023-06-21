import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel({
    this.restaurantId,
    this.address,
    this.discount,
    this.phoneNumber,
    this.paymentMethod,
    this.receiveTime,
    this.totalPrice,
    this.orderDetails,
  });

  int? restaurantId;
  String? address;
  int? discount;
  String? phoneNumber;
  String? paymentMethod;
  int? receiveTime;
  double? totalPrice;
  List<OrderDetailModel>? orderDetails;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
