import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';


class RegisterView extends GetView<SignUpController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }

  
}
