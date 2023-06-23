import 'package:foodapp/app/core.dart';

class CartManager {
  CartCacheService cartCacheService;

  CartManager({required this.cartCacheService});

  Future<bool> initSession() async {
    await cartCacheService.init();
    return true;
  }

  CartModel? getCart() {
    var data = cartCacheService.repo.getAllValues();
    if (data.isEmpty) return null;
    return data.values.first;
  }

  Future<void> saveCart(CartModel? cartModel) async {
    if (cartModel == null) return;
    await cartCacheService.repo.putAndUpdateExisting(
      AppKeys.cartKey,
      cartModel,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }

  Future<void> deleteCart() async {
    await cartCacheService.repo.deleteKeys([AppKeys.cartKey]);
  }
}
