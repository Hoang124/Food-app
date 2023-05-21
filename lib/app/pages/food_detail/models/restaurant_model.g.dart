// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      closeTime: json['closeTime'] as String?,
      startTime: json['startTime'] as String?,
      image: json['image'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      foodItemRespList: (json['foodItemRespList'] as List<dynamic>?)
          ?.map((e) => FoodResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'lng': instance.lng,
      'lat': instance.lat,
      'startTime': instance.startTime,
      'closeTime': instance.closeTime,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
      'foodItemRespList': instance.foodItemRespList,
    };
