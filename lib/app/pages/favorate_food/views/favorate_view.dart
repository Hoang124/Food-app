import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class FavorateView extends GetView<FavorateController> {
  const FavorateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [_menuStore(context)],
          ),
        ),
      ),
    );
  }

  Widget _menuStore(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).yourFavorate,
          style: AppTextStyles.big().copyWith(
            color: AppColors.defaultTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
        _foodStore(
          context,
          AssetsConst.food,
          "Chicken Hell",
          25000,
        ),
      ],
    );
  }

  Widget _foodStore(
    BuildContext context,
    String picture,
    String nameFood,
    double money,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.store);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameFood,
                      style: AppTextStyles.big().copyWith(
                        color: AppColors.defaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "1,8 km",
                          style: AppTextStyles.tiny().copyWith(
                            color: const Color(0xff8E97A6),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xffF7EDD0).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        money.toString(),
                        style: AppTextStyles.subHeading1().copyWith(
                          color: AppColors.defaultTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    Image.asset(
                      picture,
                      height: 110,
                    ),
                    Positioned(
                      right: 0,
                      child: Transform.translate(
                        offset: const Offset(10, 0),
                        child: SvgPicture.asset(
                          AssetsConst.tymIcon,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
