import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _languageClick() {
    Get.toNamed(Routes.language);
  }

  void _changePassClick() {}
  //void _notificationClick() {}
  void _helpCenterClick() {}
  void _aboutClick() {
    Get.toNamed(Routes.feedback);
  }

  void _logoutClick() {
    controller.logoutUser();
  }

  void _historyClick() {
    Get.toNamed(Routes.history);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetsConst.avatarr),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.of(context).hi("Hoang"),
                                style: AppTextStyles.heading1()
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          S.of(context).niceDay,
                          style: AppTextStyles.tiny()
                              .copyWith(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _contentWidget(
                context,
                S.of(context).language,
                AssetsConst.icLanguage,
                _languageClick,
              ),
              _contentWidget(
                context,
                S.of(context).changePass,
                AssetsConst.icChangPass,
                _changePassClick,
              ),
              _contentWidget(
                context,
                S.of(context).helpCenter,
                AssetsConst.icHelp,
                _helpCenterClick,
              ),
              _contentWidget(
                context,
                S.of(context).about,
                AssetsConst.icAbout,
                _aboutClick,
              ),
              _contentWidget(
                context,
                "History",
                AssetsConst.history,
                _historyClick,
              ),
              _contentWidget(
                context,
                S.of(context).logout,
                AssetsConst.icLogout,
                _logoutClick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentWidget(
    BuildContext context,
    String title,
    String icon,
    void Function()? handle,
  ) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color(0xfff5f5f5),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 25,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      title,
                      style: AppTextStyles.body2().copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  color: AppColors.darkGrey,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
