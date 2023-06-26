import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class FeedBackView extends GetView<FeedbackController> {
  const FeedBackView({Key? key}) : super(key: key);

  _tapToShowFeedback() {
    controller.isShowFeedback = true;
  }

  void _onSubmitFeedback() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(Routes.home);
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
          ),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Image.asset(
                AssetsConst.verifed,
                height: 180,
              ),
              const SizedBox(height: 40),
              Text(
                S.of(context).deliveriedOK,
                style: AppTextStyles.heading1().copyWith(
                    color: AppColors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).tellWithUs + " 🙌",
                      style: AppTextStyles.subHeading1().copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 25),
                    RatingBar(
                      initialRating: controller.star,
                      ratingWidget: RatingWidget(
                        full: SvgPicture.asset(AssetsConst.activeStar),
                        half: const SizedBox.shrink(),
                        empty: SvgPicture.asset(AssetsConst.deactiveStar),
                      ),
                      onRatingUpdate: (value) {
                        controller.star = value;
                      },
                      itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: _tapToShowFeedback,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).writeSometh,
                            style: AppTextStyles.body1().copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            AssetsConst.pointer,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      return (controller.isShowFeedback)
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(
                                  bottom: 0, left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.grey[200] as Color,
                                    width: 1,
                                  )),
                              child: TextFormField(
                                controller: controller.feedbackController,
                                maxLength: 100,
                                decoration: InputDecoration(
                                  hintText: S.of(context).enterFeedback,
                                  hintStyle: AppTextStyles.body2().copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey[300]),
                                  fillColor: AppColors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 24, right: 24),
        child: InkWell(
          onTap: _onSubmitFeedback,
          child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  S.of(context).submit,
                  style: AppTextStyles.body1().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.main.shade400,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
