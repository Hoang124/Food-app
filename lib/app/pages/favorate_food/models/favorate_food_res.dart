import 'package:json_annotation/json_annotation.dart';

part 'favorate_food_res.g.dart';

@JsonSerializable()
class FavorateFoodRes {
  int? id;
  String? description;
  String? image;
  String? name;
  double? price;
  double? rate;
  FavorateFoodRes({
    this.id,
    this.description,
    this.image,
    this.price,
    this.rate,
  });

  factory FavorateFoodRes.fromJson(Map<String, dynamic> json) =>
      _$FavorateFoodResFromJson(json);

  Map<String, dynamic> toJson() => _$FavorateFoodResToJson(this);
}
