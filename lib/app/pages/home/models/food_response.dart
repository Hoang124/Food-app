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
  @HiveField(9)
  double? distance;
  @HiveField(10)
  String? lat;
  @HiveField(11)
  String? lng;

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
    this.distance,
    this.lat, 
    this.lng,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) =>
      _$FoodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodResponseToJson(this);
}
