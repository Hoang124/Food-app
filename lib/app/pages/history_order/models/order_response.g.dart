// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: json['id'] as int?,
      restaurantId: json['restaurantId'] as int?,
      restaurantName: json['restaurantName'] as String?,
      address: json['address'] as String?,
      discount: json['discount'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      receiveTime: json['receiveTime'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      image: json['image'] as String?,
      orderDetailList: (json['orderDetailList'] as List<dynamic>?)
          ?.map((e) => OrderDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'address': instance.address,
      'discount': instance.discount,
      'phoneNumber': instance.phoneNumber,
      'paymentMethod': instance.paymentMethod,
      'receiveTime': instance.receiveTime,
      'totalPrice': instance.totalPrice,
      'image': instance.image,
      'orderDetailList': instance.orderDetailList,
    };
