import 'package:foodapp/app/core.dart';

class CartCacheService extends CacheServiceInterface {
  final repo = CartRepo();
  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.cartBox)) {
      await Hive.openBox<CartModel>(ModelTypeDefine.cartBox);
    }
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.foodResponse)) {
      Hive.registerAdapter<FoodResponse>(FoodResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(ModelTypeDefine.cart)) {
      Hive.registerAdapter<CartModel>(CartModelAdapter());
    }
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    return super.dispose();
  }
}
