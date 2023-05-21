import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeSubView extends GetView<HomeSubController> {
  const HomeSubView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _mostFoodPopularClick(FoodResponse foodResponse) {
    Get.toNamed(Routes.foodDetail, arguments: foodResponse);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topHomeWidget(context),
                const SizedBox(height: 30),
                _searchWidget(context),
                const SizedBox(height: 30),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TabBar(
                      controller: controller.tabController,
                      splashFactory: NoSplash.splashFactory,
                      isScrollable: true,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide.none,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      tabs: [
                        _builTabBar(
                          context,
                          "Pizza",
                          0,
                          AssetsConst.pizza,
                          const Color(0xffFFDE8A),
                        ),
                        _builTabBar(
                          context,
                          "Hotdog",
                          1,
                          AssetsConst.hotdog,
                          const Color(0xffEEBBAF),
                        ),
                        _builTabBar(
                          context,
                          "Donat",
                          2,
                          AssetsConst.doughnut,
                          const Color(0xffEDB66B),
                        ),
                        _builTabBar(
                          context,
                          "Ice",
                          3,
                          AssetsConst.ice,
                          const Color(0xff5A85FF),
                        ),
                        _builTabBar(
                          context,
                          "Asian",
                          4,
                          AssetsConst.zongzi,
                          const Color(0xff38AD68),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _mainHomeView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _builTabBar(
      BuildContext context, String text, int index, String icon, Color color) {
    return DisableAccessibility(
      child: Tab(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: controller.indexTabBar == index
                ? AppColors.primaryColor
                : color.withOpacity(0.7),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Row(
            children: [
              Text(
                text,
                style: AppTextStyles.body2().copyWith(
                    color: controller.indexTabBar == index
                        ? AppColors.white
                        : AppColors.primaryColor),
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                icon,
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _topHomeWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  S.of(context).location,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Text(
                    "Lien Chieu, Da Nang",
                    style: AppTextStyles.tiny().copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.darkGrey,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
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
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldSearch(
            inputController: controller.textEditingController,
            keyboardType: TextInputType.text,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: SvgPicture.asset(
            AssetsConst.iconFillter,
          ),
        )
      ],
    );
  }

  Widget _mainHomeView(BuildContext context) {
    return Column(
      children: [
        _mostPopular(context),
        const SizedBox(height: 20),
        _nearByRestaurant(context),
        const SizedBox(height: 20),
        _menuStore(context),
      ],
    );
  }

  Widget _mostPopular(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => controller.isLoading
            ? controller.listFood != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).mostPopular,
                        style: AppTextStyles.subLead().copyWith(
                          color: AppColors.defaultTextColor,
                        ),
                      ),
                      Row(
                        children: controller.listFood!.asMap().entries.map((e) {
                          return _cardMostPopular(
                              context, controller.listFood![e.key]);
                        }).toList(),
                      ),
                    ],
                  )
                : const SizedBox()
            : ThreeBounceLoading(),
      ),
    );
  }

  Widget _nearByRestaurant(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).nearby,
          style: AppTextStyles.subLead().copyWith(
            color: AppColors.defaultTextColor,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _cardNearbyPopular(
                context,
                AssetsConst.onboarding02,
                "The Chicken King",
              ),
              _cardNearbyPopular(
                context,
                AssetsConst.onboarding03,
                "The Chicken King",
              ),
              _cardNearbyPopular(
                context,
                AssetsConst.onboarding01,
                "The Chicken King",
              ),
              _cardNearbyPopular(
                context,
                AssetsConst.onboarding01,
                "The Chicken King",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardMostPopular(
    BuildContext context,
    FoodResponse foodResponse,
  ) {
    return InkWell(
      onTap: () {
        _mostFoodPopularClick(foodResponse);
      },
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 280,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  foodResponse.image != null
                      ? Center(
                          child: Container(
                            width: 130.0,
                            height: 130.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(foodResponse.image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              border: Border.all(
                                color: AppColors.lightPrimaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        foodResponse.name ?? "",
                        style: AppTextStyles.body1().copyWith(
                          color: AppColors.defaultTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "24min - ",
                        style: AppTextStyles.tiny().copyWith(
                          color: const Color(0xff8E97A6),
                        ),
                      ),
                      SvgPicture.asset(AssetsConst.star),
                      const SizedBox(width: 5),
                      Text(
                        foodResponse.rate.toString(),
                        style: AppTextStyles.tiny().copyWith(
                          color: const Color(0xff8E97A6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(foodResponse.price ?? 0),
                        style: AppTextStyles.subHeading1().copyWith(
                          color: AppColors.defaultTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColors.defaultTextColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Transform.translate(
              offset: const Offset(-20, 20),
              child: SvgPicture.asset(
                AssetsConst.tymIcon,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardNearbyPopular(
    BuildContext context,
    String picture,
    String nameStore,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(picture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            nameStore,
            style: AppTextStyles.heading2().copyWith(
              color: AppColors.defaultTextColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "24min - ",
                    style: AppTextStyles.tiny().copyWith(
                      color: const Color(0xff8E97A6),
                    ),
                  ),
                  SvgPicture.asset(AssetsConst.star),
                  const SizedBox(width: 5),
                  Text(
                    "4.8",
                    style: AppTextStyles.tiny().copyWith(
                      color: const Color(0xff8E97A6),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.bookmark,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuStore(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu",
          style: AppTextStyles.subLead().copyWith(
            color: AppColors.defaultTextColor,
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
                Image.asset(
                  picture,
                  height: 120,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
