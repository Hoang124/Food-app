
import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LimitedScaleFactor(
      child: Center(child: Text("home 3")),
    );
  }
}
