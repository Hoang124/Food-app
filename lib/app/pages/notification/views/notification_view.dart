import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: Center(child: Image.asset(AssetsConst.notifycationEmpty)),
    );
  }
}
