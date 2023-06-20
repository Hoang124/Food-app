import 'package:foodapp/app/core.dart';
part 'cart_model.g.dart';

@HiveType(typeId: ModelTypeDefine.cart)
class CartModel {
  CartModel({
    this.foodResponses,
    this.idUser,
  });
  @HiveField(0)
  int? idUser;
  @HiveField(1)
  List<FoodResponse>? foodResponses;
}
