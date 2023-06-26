import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class HistoryOrderView extends GetView<HistoryOrderController> {
  const HistoryOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
            color: AppColors.white,
          ),
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
    );
  }
  Widget _orderItem(
    BuildContext context,
    FoodResponse foodResponse,
  ) {
    return GestureDetector(
      onTap: () {
       
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
