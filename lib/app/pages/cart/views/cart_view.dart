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

  void _useCurrentLocation() {
    controller.getCurrentLocation();
  }

  void deleteCart(int id) {
    controller.deleteCart(id);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.foodResponses.isEmpty
          ? AppColors.fullWhite
          : AppColors.defaultBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
      bottomNavigationBar: Visibility(
        visible: controller.foodResponses.isNotEmpty,
        child: _reviewPaymentBtn(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => controller.foodResponses.isEmpty
                ? Center(child: Image.asset(AssetsConst.cartEmpty))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _mainReviewPaymentView(context),
                        const SizedBox(height: 20),
                        _totalWidget(context),
                        _addAddress(context),
                        _addBank(context),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _addBank(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).selectSource,
            style: AppTextStyles.body1().copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: DefaultValues.bankList.asMap().entries.map(
            (e) {
              return _bankWidget(
                context,
                DefaultValues.bankList[e.key],
              );
            },
          ).toList(),
        ),
        Column(
          children: List.generate(
            DefaultValues.paymentMethodList.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BuildPaymentItem(
                    title: DefaultValues.paymentMethodList[index]['title']
                        .toString(),
                    asset: DefaultValues.paymentMethodList[index]['asset']
                        .toString()),
              );
            },
          ),
        ),
      ],
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
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(foodResponse.price),
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
                  onPressed: () {
                    deleteCart(foodResponse.id!);
                    Navigator.of(context).pop(true);
                  },
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
    return Obx(
      () => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () {
              if (controller.getIsEnable!) {
                controller.payment();
              } else {}
            },
            style: controller.getIsEnable == true
                ? FilledBtnStyle.enable(
                    isFullWidth: true,
                    borderRadius: 16,
                  )
                : FilledBtnStyle.disable(
                    isFullWidth: true,
                    borderRadius: 16,
                  ),
            child: Text(
              S.of(context).payment,
              style: AppTextStyles.subHeading1().copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _totalWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Obx(
            () => _totalItem(
              context,
              S.of(context).subtotal,
              controller.totalPrice,
              false,
            ),
          ),
          const SizedBox(height: 10),
          _totalItem(
            context,
            S.of(context).delivery,
            0,
            false,
          ),
          const SizedBox(height: 10),
          Obx(
            () => _totalItem(
              context,
              S.of(context).total,
              controller.totalPrice,
              true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bankWidget(BuildContext context, BankModel bankModel) {
    return InkWell(
      onTap: () {
        // _seclectedBank(bankModel);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 350),
          child: Container(
            decoration: BoxDecoration(
                color: 0 == bankModel.id
                    ? AppColors.primaryColor.withOpacity(0.7)
                    : AppColors.grey.shade500,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      bankModel.logo,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: Get.width * 0.62,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildTextTitle(
                            text: bankModel.nameBank,
                            color: 0 == bankModel.id
                                ? AppColors.main.shade400
                                : AppColors.grey,
                          ),
                          BuildTextBody(
                              text: bankModel.desBank,
                              color: 0 == bankModel.id
                                  ? AppColors.main.shade400
                                  : AppColors.grey)
                        ],
                      ),
                    ),
                  ],
                ),
                0 == bankModel.id
                    ? SvgPicture.asset(AssetsConst.activeCircle)
                    : SvgPicture.asset(AssetsConst.disableCircle)
              ],
            ),
          ),
        ),
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
          NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(money),
          style: style,
        ),
      ],
    );
  }

  Widget _addAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type your address to delivery",
          style: AppTextStyles.body1(),
        ),
        const SizedBox(height: 10),
        TextFieldInput(
          key: const ValueKey('notes'),
          labelText: "S.of(context).notes",
          inputController: controller.addAddress,
          tagId: "notes",
          textStyle: AppTextStyles.body1(),
          textInputAction: TextInputAction.done,
          maxLines: 1,
          fillColor: AppColors.lightPrimaryColor,
        ),
        GestureDetector(
          onTap: _useCurrentLocation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 6),
                Text(
                  "Use my current location",
                  style: AppTextStyles.body2()
                      .copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BuildPaymentItem extends StatelessWidget {
  const BuildPaymentItem({
    Key? key,
    required this.title,
    required this.asset,
  }) : super(key: key);
  final String title;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey[00],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(asset),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildTextTitle(text: title, color: AppColors.grey),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(AssetsConst.greaterSymbol)
          ],
        ),
      ),
    );
  }
}

class BuildTextTitle extends StatelessWidget {
  const BuildTextTitle({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.tiny()
          .copyWith(fontWeight: FontWeight.w600, color: color),
    );
  }
}

class BuildTextBody extends StatelessWidget {
  const BuildTextBody({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.tiny()
          .copyWith(fontWeight: FontWeight.w400, color: color),
    );
  }
}
