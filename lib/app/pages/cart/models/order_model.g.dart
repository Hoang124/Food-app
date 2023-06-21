// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      restaurantId: json['restaurantId'] as int?,
      address: json['address'] as String?,
      discount: json['discount'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      receiveTime: json['receiveTime'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'address': instance.address,
      'discount': instance.discount,
      'phoneNumber': instance.phoneNumber,
      'paymentMethod': instance.paymentMethod,
      'receiveTime': instance.receiveTime,
      'totalPrice': instance.totalPrice,
      'orderDetails': instance.orderDetails,
    };
