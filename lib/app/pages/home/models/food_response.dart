import 'package:json_annotation/json_annotation.dart';

part 'food_response.g.dart';

@JsonSerializable()
class FoodResponse {
  int? id;
  String? name;
  double? rate;
  String? image;
  double? price;

  FoodResponse({
    this.id,
    this.name,
    this.rate,
    this.image,
    this.price,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) =>
      _$FoodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodResponseToJson(this);
}
