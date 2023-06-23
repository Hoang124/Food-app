import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel({
    this.restaurantId,
    this.address,
    this.discount,
    this.paymentMethod,
    this.totalPrice,
    this.orderDetailList,
  });

  int? restaurantId;
  String? address;
  int? discount;
  String? paymentMethod;
  double? totalPrice;
  List<OrderDetailModel>? orderDetailList;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
