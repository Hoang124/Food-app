import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2 - 50),
            child: Center(
              child: SvgPicture.asset(AssetsConst.logo),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    color: AppColors.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
