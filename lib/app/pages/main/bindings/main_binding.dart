import 'package:foodapp/app/core.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    var loginCatchService = Get.put(LoginCacheService());
    SessionStore ssStore = Get.put<SessionStore>(SessionStore());
    AuthHttpService authHttp = Get.put<AuthHttpService>(AuthHttpService());
    var sessionM = SessionManager(store: ssStore, authService: authHttp);
    Get.put<SessionManager>(sessionM);
    Get.put(LoginManager(loginCacheService: loginCatchService));
    Get.put<AuthHttpService>(AuthHttpService());
    var cartCacheService = Get.put<CartCacheService>(CartCacheService());
    Get.put<CartManager>(CartManager(cartCacheService: cartCacheService));
    Get.put(MainController());
  }
}
