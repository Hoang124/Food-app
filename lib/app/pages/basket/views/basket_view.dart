import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class BasketView extends GetView<BasketController> {
  const BasketView({Key? key}) : super(key: key);

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
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: 30,
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Cart",
          style: AppTextStyles.body1().copyWith(color: AppColors.white),
        ),
      ),
      bottomNavigationBar: _goToCartBtn(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).addedItems,
                  style: AppTextStyles.heading1(),
                ),
              ),
              _mainBasketView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBasketWidget(BuildContext context, String name, String price) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                AssetsConst.food,
                height: 100,
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    name,
                    style: AppTextStyles.body1(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    price,
                    style: AppTextStyles.body1(),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  _minusWiget(context),
                  Text(
                    "03",
                    style: AppTextStyles.body1().copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  _plusWiget(context),
                ],
              ),
              Text(
                "123",
                style: AppTextStyles.body1(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _minusWiget(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blackColor)),
      child: const Icon(
        Icons.remove,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _plusWiget(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blackColor)),
      child: const Icon(
        Icons.add,
        color: AppColors.defaultBackground,
      ),
    );
  }

  Widget _topBasketWidget(BuildContext context) {
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

  Widget _goToCartBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: null,
        style: FilledBtnStyle.enable(
          isFullWidth: true,
          borderRadius: 16,
          background: AppColors.primaryColor,
        ),
        child: Text(S.of(context).goToCart),
      ),
    );
  }

  Widget _mainBasketView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemBasketWidget(context, "Pizza", "19.00"),
          _itemBasketWidget(context, "Pasta", "21.00"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
