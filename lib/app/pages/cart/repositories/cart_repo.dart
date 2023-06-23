import 'package:foodapp/app/core.dart';

class CartRepo extends ActiveRepo<String, CartModel> {
  @override
  String get boxName => ModelTypeDefine.cartBox;
}
