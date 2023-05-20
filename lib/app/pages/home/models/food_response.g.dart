// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodResponse _$FoodResponseFromJson(Map<String, dynamic> json) => FoodResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FoodResponseToJson(FoodResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
    };
