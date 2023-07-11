import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class HistoryOrderView extends GetView<HistoryOrderController> {
  const HistoryOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _orderDetailItemClick(FoodResponse foodResponse) {
    Get.toNamed(Routes.foodDetail, arguments: foodResponse);
  }

  Widget _buildBody(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.defaultBackground,
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
          elevation: 0.0,
          title: Text(
            S.of(context).historyOrder,
            style: AppTextStyles.subLead().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: controller.isLoading == true
            ? controller.orderResponseList != null
                ? SingleChildScrollView(
                    child: Column(
                        children: controller.orderResponseList!
                            .map((e) => _expansionOrder(context, e))
                            .toList()),
                  )
                : const SizedBox()
            : const SizedBox(),
      ),
    );
  }

  Widget _expansionOrder(BuildContext context, OrderResponse orderResponse) {
    return Card(
      child: ExpansionTile(
        title: _orderItem(
          context,
          orderResponse,
        ),
        trailing: Text(S.of(context).detail),
        children: orderResponse != null
            ? orderResponse.orderDetailList != null &&
                    orderResponse.orderDetailList!.isNotEmpty
                ? orderResponse.orderDetailList!
                    .map((e) => _orderDetailItem(context, e))
                    .toList()
                : []
            : [],
      ),
    );
  }

  Widget _orderDetailItem(
      BuildContext context, OrderDetailResponse orderDetailResponse) {
    return GestureDetector(
      onTap: () {
        _orderDetailItemClick(orderDetailResponse.foodItemResponse!);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  orderDetailResponse.foodItemResponse?.image != null
                      ? Center(
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: AppColors.lightPrimaryColor,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: CachedNetworkImage(
                                imageUrl: orderDetailResponse
                                    .foodItemResponse!.image!,
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
                          orderDetailResponse.foodItemResponse!.name.toString(),
                          style: AppTextStyles.body1().copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(
                                  orderDetailResponse.foodItemResponse!.price),
                          style: AppTextStyles.body1().copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400),
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
                    Text(
                      "x${orderDetailResponse.quantity.toString()}",
                      style: AppTextStyles.body1().copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Text(
                  NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                      .format(orderDetailResponse.subTotal),
                  style: AppTextStyles.body1().copyWith(
                      color: AppColors.blackColor, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderItem(BuildContext context, OrderResponse orderResponse) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    orderResponse.image != null
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
                                  imageUrl: orderResponse.image!,
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
                            orderResponse.restaurantName.toString(),
                            style: AppTextStyles.body1(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            controller
                                .getDateTime(orderResponse.receiveTime ?? 0),
                            style: AppTextStyles.body2().copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).totalPrice,
                                style: AppTextStyles.body1(),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'vi_VN', symbol: '₫')
                                    .format(orderResponse.totalPrice),
                                style: AppTextStyles.body1(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
