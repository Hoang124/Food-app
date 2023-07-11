// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailResponse _$OrderDetailResponseFromJson(Map<String, dynamic> json) =>
    OrderDetailResponse(
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      foodItemResponse: json['foodItemResponse'] == null
          ? null
          : FoodResponse.fromJson(
              json['foodItemResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailResponseToJson(
        OrderDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'subTotal': instance.subTotal,
      'foodItemResponse': instance.foodItemResponse,
    };
