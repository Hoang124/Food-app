// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      restaurantId: json['restaurantId'] as int?,
      address: json['address'] as String?,
      discount: json['discount'] as int?,
      paymentMethod: json['paymentMethod'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderDetailList: (json['orderDetailList'] as List<dynamic>?)
          ?.map((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'address': instance.address,
      'discount': instance.discount,
      'paymentMethod': instance.paymentMethod,
      'totalPrice': instance.totalPrice,
      'orderDetailList': instance.orderDetailList,
    };
