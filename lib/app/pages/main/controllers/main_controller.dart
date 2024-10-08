import 'dart:async';
import 'package:flutter/services.dart';
import '../../../core.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  late LoginManager _loginManager;
  late final SessionManager _sessionM;
  late final CartManager _cartManager;

  LoginResp? loginResp;
  @override
  void onInit() {
    _loginManager = Get.find<LoginManager>();
    _cartManager = Get.find<CartManager>();
    appInitializer();
    super.onInit();
  }

  @override
  void onClose() async {
    await HiveManager.close();
    super.onClose();
  }

  Future<void> appInitializer() async {
    await Prefs.load();
    DioClient.clearInterceptors(DioClient.currentDio());
    _sessionM = Get.find<SessionManager>();

    // DioClient.setInterceptorRetry(DioClient.currentDio());
    if (BuildConfig().isDebug) {
      DioClient.setInterceptorLogger(
        DioClient.currentDio(),
        printOnSuccess: true,
      );
    }

    //client service
    DioClient.onErrorHandle = AppApiError.errorMessageHandle;
    DioClient.updateBaseUrl(
      DioClient.currentDio(),
      Uri.parse(BuildConfig().env.baseApi),
    );
    DioClient.updateTimeOut(
      DioClient.currentDio(),
      connectTimeOut: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    //Init Hive
    await HiveManager.init();
    await _loginManager.initSession();
    await _cartManager.initSession();
    //Set Language
    String lang = Prefs.getString(AppKeys.languageKey, defaultValue: "en_US");
    await MyApp.of(Get.context!)?.changeLanguage(lang);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    loginResp = _loginManager.getUser();
    //Delay for show Splash screen
    await Future.delayed(const Duration(seconds: 2), () {
      checkFistLaunch();
    });
  }

  Future<void> checkFistLaunch() async {
    if (loginResp != null) {
      bool isAuthenticated = await _isAuthenticated();
      if (isAuthenticated) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.signIn);
      }
    } else {
      bool isNotFirstLaunch = Prefs.getBool(AppKeys.firstLaunch);
      if (isNotFirstLaunch) {
        Get.offNamed(Routes.onboarding);
      } else {
        await Prefs.saveBool(AppKeys.firstLaunch, true);
        Get.offNamed<void>(Routes.onboarding);
      }
    }
  }

  Future<bool> _isAuthenticated() async {
    bool checkSession = _sessionM.hasSession();
    if (checkSession) {
      await _sessionM.initSession(_sessionM.session!);
      return true;
    } else {
      return false;
    }
  }
}
