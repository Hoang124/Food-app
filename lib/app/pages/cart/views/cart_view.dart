import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _mainReviewPaymentView(context),
                const SizedBox(height: 20),
                _totalWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemCartWidget(BuildContext context, FoodResponse foodResponse) {
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
          Expanded(
            child: Row(
              children: [
                // Image.asset(
                //   foodResponse.image ?? AssetsConst.food,
                //   height: 100,
                // ),
                foodResponse.image != null
                    ? Center(
                        child: Container(
                          width: 100.0,
                          height: 100.0,
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
                    : const SizedBox(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodResponse.name.toString(),
                        style: AppTextStyles.body1(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        foodResponse.price.toString(),
                        style: AppTextStyles.body1(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.minusQuantity(foodResponse.id ?? 0),
                    child: _minusWiget(context),
                  ),
                  Text(
                    foodResponse.quantity == null
                        ? "1"
                        : foodResponse.quantity.toString(),
                    style: AppTextStyles.body1().copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () => controller.plusQuantity(foodResponse.id ?? 0),
                    child: _plusWiget(context),
                  ),
                ],
              ),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(
                    foodResponse.quantity == null
                        ? foodResponse.price
                        : foodResponse.price! * foodResponse.quantity!),
                style: AppTextStyles.body1(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _dismissibleWidget(BuildContext context, FoodResponse foodResponse) {
    return Dismissible(
      key: Key(foodResponse.id.toString()),
      onDismissed: (direction) {},
      confirmDismiss: (direction) async {
        final bool shouldDelete = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận"),
              content:
                  Text("Bạn có chắc chắn muốn xoá ${foodResponse.name} không?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Xoá"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Huỷ"),
                ),
              ],
            );
          },
        );

        // Trả về false để ngăn không cho widget bị xoá
        return shouldDelete;
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
      dragStartBehavior: DragStartBehavior.down,
      direction: DismissDirection.endToStart,
      child: _itemCartWidget(
        context,
        foodResponse,
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
      child: Obx(
        () => controller.foodResponses.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.foodResponses
                    .map((foodResponse) =>
                        _dismissibleWidget(context, foodResponse))
                    .toList(),
              )
            : SizedBox.shrink(),
      ),
    );
  }

  Widget _totalWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _totalItem(
            context,
            S.of(context).subtotal,
            100,
            false,
          ),
          const SizedBox(height: 10),
          _totalItem(
            context,
            S.of(context).delivery,
            0,
            false,
          ),
          const SizedBox(height: 10),
          _totalItem(
            context,
            S.of(context).total,
            100,
            true,
          ),
        ],
      ),
    );
  }

  Widget _totalItem(
    BuildContext context,
    String name,
    double money,
    bool isTotal,
  ) {
    TextStyle style = isTotal
        ? AppTextStyles.big().copyWith(fontWeight: FontWeight.w600)
        : AppTextStyles.body1().copyWith(fontWeight: FontWeight.w400);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: style,
        ),
        Text(
          money.toString(),
          style: style,
        ),
      ],
    );
  }
}
