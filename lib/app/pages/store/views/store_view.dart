import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.cart);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Builder(builder: (context) {
                return Stack(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart_sharp,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: Center(
                        child: Text(
                          controller.cartQuantity != null
                              ? controller.cartQuantity.toString()
                              : '',
                          style: AppTextStyles.subHeading1().copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primaryColor.withOpacity(0.5),
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller.pageController,
                        children: [
                          _onboardingMain(
                            context,
                            AssetsConst.onboarding01,
                            S.of(context).titleOnboarding1,
                          ),
                          _onboardingMain(
                            context,
                            AssetsConst.onboarding02,
                            S.of(context).titleOnboarding2,
                          ),
                          _onboardingMain(
                            context,
                            AssetsConst.onboarding03,
                            S.of(context).titleOnboarding3,
                          ),
                          _onboardingMain(
                            context,
                            AssetsConst.onboarding02,
                            S.of(context).titleOnboarding2,
                          ),
                          _onboardingMain(
                            context,
                            AssetsConst.onboarding03,
                            S.of(context).titleOnboarding3,
                          ),
                        ],
                        onPageChanged: (int index) {
                          controller.onPageChange(index);
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        child: _bottomIndicator(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _contentWidget(context),
            _menuStore(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomIndicator(BuildContext context) {
    return Container(
      width: Get.width,
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppProperties.bottomSheetRadius),
          topRight: Radius.circular(AppProperties.bottomSheetRadius),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: 5,
            effect: const WormEffect(
              dotWidth: 12,
              dotHeight: 12,
              paintStyle: PaintingStyle.fill,
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.lightPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // void _showBottomSheet(BuildContext context) {
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) async {
  //       showModalBottomSheet(
  //         context: context,
  //         isScrollControlled: true,
  //         backgroundColor: AppColors.white,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20.0),
  //             topRight: Radius.circular(20.0),
  //           ),
  //         ),
  //         builder: (BuildContext context) {
  //           return ConstrainedBox(
  //               constraints: BoxConstraints(
  //                 maxHeight: MediaQuery.of(context).size.height * 0.8,
  //               ),
  //               child: Container());
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _onboardingMain(BuildContext context, String image, String title) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              image,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              title,
              style: AppTextStyles.heading2(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 45.0,
            height: 45.0,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(AssetsConst.avatarr),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              border: Border.all(
                color: AppColors.lightPrimaryColor,
                width: 2.0,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.restaurantModel != null
                    ? controller.restaurantModel!.name!
                    : '',
                style: AppTextStyles.heading2().copyWith(
                  color: AppColors.defaultTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.lightPink,
                  ),
                  Text(
                    "2,4km - ",
                    style: AppTextStyles.body2().copyWith(
                      color: const Color(0xff8E97A6),
                    ),
                  ),
                  SvgPicture.asset(
                    AssetsConst.star,
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "4.8",
                    style: AppTextStyles.body2().copyWith(
                      color: const Color(0xff8E97A6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.sell,
                    color: Color(0xffF9998A),
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "100+",
                    style: AppTextStyles.body2().copyWith(
                      color: const Color(0xff8E97A6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuStore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menu",
            style: AppTextStyles.subLead().copyWith(
              color: AppColors.defaultTextColor,
            ),
          ),
          Column(
            children: controller.restaurantModel!.foodItemRespList!
                .map((food) => _foodStore(context, food))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _foodStore(
    BuildContext context,
    FoodResponse foodResponse,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.foodDetail, arguments: foodResponse);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
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
                          SvgPicture.asset(AssetsConst.star),
                          const SizedBox(width: 5),
                          Text(
                            foodResponse.rate.toString(),
                            style: AppTextStyles.tiny().copyWith(
                              color: const Color(0xff8E97A6),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.sell,
                            color: Color(0xffF9998A),
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "100+",
                            style: AppTextStyles.body2().copyWith(
                              color: const Color(0xff8E97A6),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xffF7EDD0).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          S.of(context).healthy,
                          style: AppTextStyles.body2().copyWith(
                            color: const Color(0xffDAA31A),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodResponse.price.toString(),
                    style: AppTextStyles.big().copyWith(
                      color: AppColors.defaultTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.defaultTextColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
