import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/app/core.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          "Comment",
          style: AppTextStyles.body1().copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading
              ? Column(
                  children: controller.commentModels
                      .map((comment) => _commentWidget(context, comment))
                      .toList(),
                )
              : Padding(
                  padding: const EdgeInsets.all(100),
                  child: ThreeBounceLoading(),
                ),
        ),
      ),
    );
  }

  Widget _commentWidget(BuildContext context, CommentModel commentModel) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppColors.darkGrey,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AssetsConst.avatarr),
                        fit: BoxFit.cover),
                    color: AppColors.blackColor),
              ),
              Text(
                (commentModel.userResponse?.name ?? '').toString(),
                style: AppTextStyles.body2().copyWith(
                  color: AppColors.blackColor,
                ),
              )
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width - 50,
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 40,
                right: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    ratingWidget: RatingWidget(
                      full: SizedBox(
                        width: 18,
                        child: SvgPicture.asset(
                          AssetsConst.star,
                          fit: BoxFit.contain,
                        ),
                      ),
                      half: const SizedBox.shrink(),
                      empty: SizedBox(
                        width: 16,
                        child: SvgPicture.asset(
                          AssetsConst.deactiveStar,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    itemSize: 18,
                    initialRating: (commentModel.rate ?? 0).toDouble(),
                    onRatingUpdate: (value) {
                      //
                    },
                    // itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                  ),
                  const SizedBox(height: 12),
                  Text(commentModel.comment.toString()),
                  const SizedBox(height: 12),
                  Text(controller.convertDateTime(commentModel.createAt)),
                ],
              ))
        ],
      ),
    );
  }
}
