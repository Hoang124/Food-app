import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AssetsConst.sideWave),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    S.of(context).skip,
                    style: AppTextStyles.heading1().copyWith(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    AssetsConst.onboarding01,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  S.of(context).titleOnboarding1,
                  style: AppTextStyles.largeHeading1(),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Text(S.of(context).desOnboarding1,
                    style: AppTextStyles.largeHeading2().copyWith(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w300,
                    )),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
