// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorate_food_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavorateFoodRes _$FavorateFoodResFromJson(Map<String, dynamic> json) =>
    FavorateFoodRes(
      id: json['id'] as int?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
    )..name = json['name'] as String?;

Map<String, dynamic> _$FavorateFoodResToJson(FavorateFoodRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'rate': instance.rate,
    };
