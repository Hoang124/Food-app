import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends GetView<OnBoardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: buildBody(context),
    );
  }

  void _skipClick() {
    Get.offNamed(Routes.signIn);
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Stack(
        children: [
          SvgPicture.asset(AssetsConst.sideWave),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    children: [
                      _onboardingMain(
                        context,
                        AssetsConst.onboarding01,
                        S.of(context).titleOnboarding1,
                        S.of(context).desOnboarding1,
                      ),
                      _onboardingMain(
                        context,
                        AssetsConst.onboarding02,
                        S.of(context).titleOnboarding2,
                        S.of(context).desOnboarding2,
                      ),
                      _onboardingMain(
                        context,
                        AssetsConst.onboarding03,
                        S.of(context).titleOnboarding3,
                        S.of(context).desOnboarding3,
                      ),
                    ],
                    onPageChanged: (int index) {
                      controller.onPageChange(index);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: _bottomIndicator(context),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: _skipClick,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      S.of(context).skip,
                      style: AppTextStyles.subHeading1().copyWith(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomIndicator(BuildContext context) {
    return Container(
      width: Get.width,
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppProperties.bottomSheetRadius),
          topRight: Radius.circular(AppProperties.bottomSheetRadius),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: 3,
            effect: const WormEffect(
              dotWidth: 35,
              dotHeight: 12,
              paintStyle: PaintingStyle.fill,
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.lightPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onboardingMain(
      BuildContext context, String image, String title, String des) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              image,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: AppTextStyles.largeHeading2(),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              des,
              style: AppTextStyles.heading1().copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        )
      ],
    );
  }
}
