// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodResponseAdapter extends TypeAdapter<FoodResponse> {
  @override
  final int typeId = 3;

  @override
  FoodResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodResponse(
      id: fields[0] as int?,
      name: fields[1] as String?,
      rate: fields[2] as double?,
      image: fields[3] as String?,
      price: fields[4] as double?,
      description: fields[5] as String?,
      restaurantId: fields[6] as int?,
      isFavorite: fields[7] as bool?,
      quantity: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FoodResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.restaurantId)
      ..writeByte(7)
      ..write(obj.isFavorite)
      ..writeByte(8)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      isFavorite: json['isFavorite'] as bool?,
      quantity: json['quantity'] as int?,
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
      'isFavorite': instance.isFavorite,
      'quantity': instance.quantity,
    };
