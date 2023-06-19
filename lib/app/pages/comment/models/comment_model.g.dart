// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int?,
      createAt: json['createAt'] as int?,
      rate: json['rate'] as int?,
      comment: json['comment'] as String?,
      userResponse: json['userResponse'] == null
          ? null
          : UserModel.fromJson(json['userResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'rate': instance.rate,
      'comment': instance.comment,
      'userResponse': instance.userResponse,
    };
