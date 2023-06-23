import 'package:json_annotation/json_annotation.dart';
part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
  OrderDetailModel({
    this.foodId,
    this.quantity,
    this.price,
  });

  int? foodId;
  int? quantity;
  double? price;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
