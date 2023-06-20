import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_response.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.foodResponse)
class FoodResponse {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  double? rate;
  @HiveField(3)
  String? image;
  @HiveField(4)
  double? price;
  @HiveField(5)
  String? description;
  @HiveField(6)
  int? restaurantId;
  @HiveField(7)
  bool? isFavorite;
  @HiveField(8)
  int? quantity;

  FoodResponse({
    this.id,
    this.name,
    this.rate,
    this.image,
    this.price,
    this.description,
    this.restaurantId,
    this.isFavorite,
    this.quantity,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) =>
      _$FoodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodResponseToJson(this);
}
