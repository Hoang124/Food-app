import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {
  int? id;
  String? name;
  String? address;
  String? lng;
  String? lat;
  String? startTime;
  String? closeTime;
  String? image;
  String? phoneNumber;
  List<FoodResponse>? foodItemRespList;
  double? distance;
  RestaurantModel({
    this.id,
    this.name,
    this.address,
    this.lat,
    this.lng,
    this.closeTime,
    this.startTime,
    this.image,
    this.phoneNumber,
    this.foodItemRespList,
    this.distance,
  });
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
