import 'package:flutter/material.dart';
import 'package:foodapp/app/core.dart';

class SignUpController extends GetxController {
  final registerFormGlobalKey = GlobalKey<FormState>();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  FocusNode emailNode = FocusNode();

  late AuthHttpService _authHttpService;

  final RxBool _enableSignUpBtn = false.obs;
  set enableSignUpBtn(bool value) => _enableSignUpBtn.value = value;

  bool get enableSignUpBtn => _enableSignUpBtn.value;

  String get phoneNumber => phoneNumberFieldController.text.trim();

  String get password => passwordFieldController.text.trim();

  String get passwordAgain => passwordAgainController.text.trim();

  String get name => nameFieldController.text.trim();

  String get email => emailFieldController.text.trim();

  bool _passMatch = false;

  @override
  void onInit() {
    Get.put(AuthHttpService());
    _authHttpService = Get.find<AuthHttpService>();
    emailNode.addListener(() {
      emailFieldController.text = emailFieldController.text.trim();
    });
    super.onInit();
  }

  String? accountValidation(String? value) {
    if (value != null && StringExtensions(value).isEmail()) {
      return null;
    } else {
      return S.current.invalidEmailAddress;
    }
  }

  String? passWordAgain(String? value) {
    if (value != null && value == password) {
      _passMatch = true;
      return null;
    } else {
      _passMatch = false;
      return S.current.passwordAganNotMatch;
    }
  }

  String? passwordValidation(String? value) {
    if (value == null || value.length < 8) {
      return S.current.invalidPasswordLength;
    } else if (!StringExtensions(value).isLeastOneLetter()) {
      return S.current.invalidPasswordOneLetter;
    } else if (!StringExtensions(value).isLeastOneNumber()) {
      return S.current.invalidPasswordOneNumber;
    } else {
      return null;
    }
  }

  bool get isFormValided {
    if (phoneNumber.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        _passMatch == false) {
      return false;
    } else {
      return true;
    }
  }

  void checkFormValidation() {
    passWordAgain(passwordAgain);
    if (phoneNumber.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        _passMatch == false) {
      enableSignUpBtn = false;
    } else {
      enableSignUpBtn = true;
    }
  }

  Future<void> signUpClick() async {
    SignUpReq signUpReq = SignUpReq(
      phoneNumber: phoneNumber,
      email: email,
      nameUser: name,
      password: password,
    );
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res = await _authHttpService.signUp(signUpReq);
    if (res.isSuccess()) {
      processingDialog.hide();
      phoneNumberFieldController.clear();
      nameFieldController.clear();
      emailFieldController.clear();
      passwordFieldController.clear();
      passwordAgainController.clear();
      Get.back(result: true);
    } else {
      processingDialog.hide();
      SnackBars.error(message: res.response.toString()).show();
    }
  }
}
