import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:intl/intl.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  void _search() {
    controller.search();
  }

  void _searchItemClick(FoodResponse foodResponse) {
    Get.offAndToNamed(Routes.foodDetail, arguments: foodResponse);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    double imgRatio = 148.0 / 130.0;
    int numOfRow = 2;
    double contentMargin = 2;
    double crossSpace = contentMargin;
    double widthOfImg = (Get.width - contentMargin - crossSpace) / numOfRow;
    double heightOfImg = widthOfImg / imgRatio;
    double cardRatio = widthOfImg / (heightOfImg + 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).search),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
          onPressed: () {
            Get.offAllNamed(Routes.home);
          },
        ),
      ),
      backgroundColor: AppColors.fullWhite.withOpacity(0.9),
      body: Column(
        children: [
          _searchWidget(context),
          Obx(
            () => controller.isLoading
                ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                        child: Obx(
                          () => GridView.count(
                            physics: const AlwaysScrollableScrollPhysics(),
                            crossAxisCount: numOfRow,
                            childAspectRatio: cardRatio,
                            crossAxisSpacing: crossSpace,
                            mainAxisSpacing: contentMargin,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: controller.filteredGridItems,
                          ),
                        )),
                  )
                : Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: ThreeBounceLoading())),
          ),
        ],
      ),
    );
  }

  Widget _searchWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 10, 0),
      child: Row(
        children: [
          Expanded(
            child: TextFieldSearch(
              inputController: controller.textEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                _search();
              },
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
      ),
    );
  }

  Widget searchItem(
    BuildContext context,
    FoodResponse? foodResponse,
  ) {
    return InkWell(
      onTap: () {
        _searchItemClick(foodResponse!);
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
                  foodResponse?.image != null
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
                                imageUrl: foodResponse?.image ?? "",
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
                  const SizedBox(height: 20),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        foodResponse?.name ?? "",
                        style: AppTextStyles.body1().copyWith(
                          color: AppColors.defaultTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text(
                      //   "24min - ",
                      //   style: AppTextStyles.tiny().copyWith(
                      //     color: const Color(0xff8E97A6),
                      //   ),
                      // ),
                      SvgPicture.asset(AssetsConst.star),
                      const SizedBox(width: 5),
                      Text(
                        foodResponse?.rate.toString() ?? "0",
                        style: AppTextStyles.tiny().copyWith(
                          color: const Color(0xff8E97A6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(foodResponse?.price ?? 0),
                        style: AppTextStyles.subHeading1().copyWith(
                          color: AppColors.defaultTextColor,
                          fontWeight: FontWeight.w700,
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
                foodResponse?.isFavorite == true
                    ? AssetsConst.tymIcon
                    : AssetsConst.tymIconUn,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
