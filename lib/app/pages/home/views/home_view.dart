import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _cartClick() {
    Get.toNamed(Routes.cart);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        onPressed: _cartClick,
        // child: const Icon(
        //   Icons.add_shopping_cart_sharp,
        //   color: AppColors.primaryColor,
        //   size: 30,
        // ),
        child: Stack(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_shopping_cart_sharp,
                color: AppColors.primaryColor,
                size: 30,
              ),
            ),
            Positioned(
              top: -2,
              right: 9,
              child: Center(
                child: Text(
                  controller.cartQuantity != null
                      ? controller.cartQuantity.toString()
                      : '',
                  style: AppTextStyles.subHeading1().copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _itemNavigatorBar(
                context,
                0,
                AssetsConst.homeIconUn,
                AssetsConst.homeIcon,
              ),
              _itemNavigatorBar(
                context,
                1,
                AssetsConst.tymIconUn,
                AssetsConst.tymIcon,
              ),
              _itemNavigatorBar(
                context,
                2,
                AssetsConst.bellIconUn,
                AssetsConst.bellIcon,
              ),
              _itemNavigatorBar(
                context,
                3,
                AssetsConst.personIconUn,
                AssetsConst.personIcon,
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () => PageStorage(
          child: controller.getWidget(),
          bucket: controller.bucket,
        ),
      ),
    );
  }

  Widget _itemNavigatorBar(
      BuildContext context, int index, String iconDis, String iconActive) {
    return Obx(
      () => MaterialButton(
        shape: const CircleBorder(),
        color: controller.currentTab == index ? AppColors.white : null,
        padding: const EdgeInsets.all(12),
        onPressed: () {
          controller.currentTab = index;
        },
        child: controller.currentTab == index
            ? SvgPicture.asset(iconActive)
            : SvgPicture.asset(iconDis),
      ),
    );
  }
}
