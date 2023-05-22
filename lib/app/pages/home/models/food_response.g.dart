// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodResponse _$FoodResponseFromJson(Map<String, dynamic> json) => FoodResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      restaurantId: json['restaurantId'] as int?,
      favorite: json['favorite'] as bool?,
    );

Map<String, dynamic> _$FoodResponseToJson(FoodResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rate': instance.rate,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
      'restaurantId': instance.restaurantId,
      'favorite': instance.favorite,
    };
