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

  void _formOnChange() {
    controller.checkFormValidation();
  }

  void _signInOnClicked() {
   // Get.offAllNamed(Routes.signin);
  }

  void _signupOnClicked() {
    //Get.offAllNamed(Routes.signin);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Container()
    );
  }

  
}
