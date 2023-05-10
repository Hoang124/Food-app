import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class FoodDetailView extends GetView<FoodDetailController> {
  const FoodDetailView({Key? key}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              AssetsConst.tymIcon,
              height: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigator(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topWidget(context),
            const SizedBox(height: 30),
            _contentWidget(context),
            const SizedBox(height: 20),
            _infoStore(context),
            _foodOdStore(context),
            _commentWidget(context)
          ],
        ),
      ),
    );
  }

  Widget _topWidget(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: AppColors.primaryColor.withOpacity(0.5),
      child: Transform.translate(
        offset: const Offset(0, 50),
        child: Image.asset(
          AssetsConst.food,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chicken Hell",
                    style: AppTextStyles.largeHeading2().copyWith(
                      color: AppColors.defaultTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "24min - ",
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
              _numFood(context),
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
          Text(
            S.of(context).description,
            style: AppTextStyles.subHeading1().copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Chicken Hell Is The Healthies Chicken For Gym Guys And Girls. It Promote Healthy Life Style And Make Your Energy Booster.",
            style: AppTextStyles.body2().copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Widget _numFood(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.remove,
            color: AppColors.white,
          ),
          const SizedBox(width: 15),
          Text(
            "1",
            style: AppTextStyles.big().copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 15),
          const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "100.000",
              style: AppTextStyles.heading1()
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              S.of(context).addToCard,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoStore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    "Chicken Hell",
                    style: AppTextStyles.subHeading1().copyWith(
                      color: AppColors.defaultTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Hoà Vang, Đà Nẵng",
                    style: AppTextStyles.small().copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.store);
                },
                child: Text(
                  S.of(context).showRestaurent,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primaryColor,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _cardMostPopular(
    BuildContext context,
    String picture,
    String nameFood,
    double money,
  ) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.foodDetail);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(picture),
                Positioned(
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(10, -10),
                    child: SvgPicture.asset(
                      AssetsConst.tymIcon,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              nameFood,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.defaultTextColor,
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
                  "4.8",
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
                  money.toString(),
                  style: AppTextStyles.big().copyWith(
                    color: AppColors.defaultTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 40),
                Container(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _foodOdStore(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _cardMostPopular(
            context,
            AssetsConst.food,
            "Chicken Hell",
            25000,
          ),
          _cardMostPopular(
            context,
            AssetsConst.food,
            "Chicken Hell",
            25000,
          ),
          _cardMostPopular(
            context,
            AssetsConst.food,
            "Chicken Hell",
            25000,
          ),
          _cardMostPopular(
            context,
            AssetsConst.food,
            "Chicken Hell",
            25000,
          ),
        ],
      ),
    );
  }

  Widget _commentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Comment",
            style: AppTextStyles.body1(),
          )
        ],
      ),
    );
  }
}
