import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class FoodDetailView extends GetView<FoodDetailController> {
  const FoodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _addClick() {
    controller.plusFood();
  }

  void _minusClick() {
    controller.minusFood();
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
      child: Center(
        child: Transform.translate(
            offset: const Offset(0, 30),
            child: controller.foodResponse!.image != null
                ? Container(
                    width: 250.0,
                    height: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(controller.foodResponse!.image!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      border: Border.all(
                        color: AppColors.lightPrimaryColor,
                        width: 2.0,
                      ),
                    ),
                  )
                : Image.asset(
                    AssetsConst.food,
                    fit: BoxFit.contain,
                  )),
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.foodResponse?.name ?? "",
                      style: AppTextStyles.subLead().copyWith(
                        color: AppColors.defaultTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                              controller.foodResponse?.rate.toString() ?? "0",
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
                        _numFood(context),
                      ],
                    ),
                  ],
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
          Text(
            S.of(context).description,
            style: AppTextStyles.subHeading1().copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            controller.foodResponse?.description ?? "",
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _minusClick,
            child: const Icon(
              Icons.remove,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 15),
          Obx(
            () => Text(
              controller.numFood.toString(),
              style: AppTextStyles.big().copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: _addClick,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
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
            child: Obx(
              () => Text(
                controller.getMomey(),
                style: AppTextStyles.heading1()
                    .copyWith(fontWeight: FontWeight.w600),
              ),
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
      child: Obx(
        () => controller.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  controller.restaurantModel!.image!),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.restaurantModel!.name!,
                                style: AppTextStyles.subHeading1().copyWith(
                                  color: AppColors.defaultTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                controller.restaurantModel!.address!,
                                style: AppTextStyles.small().copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
              )
            : ThreeBounceLoading(),
      ),
    );
  }

  Widget _cardMostPopular(
    BuildContext context,
    FoodResponse foodResponse,
  ) {
    return InkWell(
      onTap: () {},
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

  Widget _foodOdStore(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => controller.isLoading
            ? controller.restaurantModel != null &&
                    controller.restaurantModel!.foodItemRespList != null
                ? Row(
                    children: controller.restaurantModel!.foodItemRespList!
                        .asMap()
                        .entries
                        .map((e) {
                    return _cardMostPopular(context,
                        controller.restaurantModel!.foodItemRespList![e.key]);
                  }).toList())
                : const SizedBox()
            : ThreeBounceLoading(),
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
