import 'package:foodapp/app/pages/comment/comment.dart';

import '../../core.dart';
part 'app_routes.dart';

class AppPages {
  static const intilial = Routes.main;
  static final routes = [
    GetPage<dynamic>(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.zoom,
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.signIn,
      page: () => const SignInView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.foodDetail,
      page: () => const FoodDetailView(),
      binding: FoodDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.basket,
      page: () => const BasketView(),
      binding: BasketBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.store,
      page: () => const StoreView(),
      binding: StoreBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.language,
      page: () => const LanguageView(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.favorate,
      page: () => const FavorateView(),
      binding: FavorateBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.comment,
      page: () => const CommentView(),
      binding: CommentBinding(),
      transition: Transition.rightToLeft,
    )
  ];
}
