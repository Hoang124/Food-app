import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';

class HomeSubView extends GetView<HomeSubController> {
  const HomeSubView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("home1"),
      ),
    );
  }
}
