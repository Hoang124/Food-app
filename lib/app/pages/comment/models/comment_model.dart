import 'package:foodapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  int? id;
  int? createAt;
  int? rate;
  String? comment;
  UserModel? userResponse;
  CommentModel({
    this.id,
    this.createAt,
    this.rate,
    this.comment,
    this.userResponse,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
