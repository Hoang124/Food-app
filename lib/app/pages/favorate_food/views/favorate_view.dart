import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavorateView extends GetView<FavorateController> {
  const FavorateView({Key? key}) : super(key: key);

  void _favorateFoodClick(FoodResponse foodResponse) {
    Get.toNamed(Routes.foodDetail, arguments: foodResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
        Column(
          children: controller.faFood
              .map((food) => _foodStore(context, food))
              .toList(),
        )
      ],
    );
  }

  Widget _foodStore(
    BuildContext context,
    FoodResponse foodResponse,
  ) {
    return GestureDetector(
      onTap: () {
        _favorateFoodClick(foodResponse);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodResponse.name.toString(),
                    style: AppTextStyles.big().copyWith(
                      color: AppColors.defaultTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                      foodResponse.price.toString(),
                      style: AppTextStyles.subHeading1().copyWith(
                        color: AppColors.defaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Stack(
              children: [
                foodResponse.image != null
                    ? Center(
                        child: Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            border: Border.all(
                              color: AppColors.lightPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.0),
                            child: CachedNetworkImage(
                              imageUrl: foodResponse.image!,
                              placeholder: (context, url) =>
                                  ThreeBounceLoading(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  SvgPicture.asset(
                                AssetsConst.food,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Image.asset(
                        AssetsConst.food,
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
      ),
    );
  }
}
