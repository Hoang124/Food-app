import 'package:json_annotation/json_annotation.dart';
import 'package:foodapp/app/core.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.user)
class UserModel {
  UserModel(
      {this.userId, this.name, this.birthDay, this.phoneNumber, this.address});
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? birthDay;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? address;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
