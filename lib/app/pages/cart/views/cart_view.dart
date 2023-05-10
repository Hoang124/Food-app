import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/app/core.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

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
          "Review Payment",
          style: AppTextStyles.body1().copyWith(color: AppColors.white),
        ),
      ),
      bottomNavigationBar: _reviewPaymentBtn(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mainReviewPaymentView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemCartWidget(BuildContext context, String name, String price) {
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

  Widget _dismissibleWidget(BuildContext context, String name, String price) {
    return Dismissible(
      key: Key(name),
      onDismissed: (direction) {},
      confirmDismiss: (direction) async {
        return false;
      },
      background: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 50),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: AppColors.primaryColor,
          ),
          child: SvgPicture.asset(AssetsConst.trash),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
        ),
      ),
      direction: DismissDirection.endToStart,
      // onResize: () {
      //   return;
      // },
      child: _itemCartWidget(
        context,
        name,
        price,
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

  Widget _reviewPaymentBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      child: ElevatedButton(
        onPressed: null,
        style: FilledBtnStyle.enable(
          isFullWidth: true,
          borderRadius: 16,
        ),
        child: Text(
          S.of(context).reviewPayment,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _mainReviewPaymentView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _itemCartWidget(context, "Pizza", "19.00"),
          _dismissibleWidget(context, "pizza", "19.00"),
          _dismissibleWidget(context, "Pasta", "21.00"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
