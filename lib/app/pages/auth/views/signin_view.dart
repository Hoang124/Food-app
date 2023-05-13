import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

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
    controller.signIn();
  }

  void _forgotPasswordOnClicked() {
    Get.offNamed(Routes.home);
  }

  void _signupOnClicked() {
    Get.toNamed(Routes.register);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 250,
              left: 10,
              right: 10,
            ),
            child: _mainSignIn(context),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset(AssetsConst.coffeeSignIn),
          ),
          Positioned(
            top: 150,
            right: 200,
            child: SvgPicture.asset(AssetsConst.signInPink),
          ),
          Positioned(
            top: 300,
            right: 150,
            child: SvgPicture.asset(AssetsConst.signInPinkSmall),
          ),
          Positioned(
            top: 200,
            right: 70,
            child: SvgPicture.asset(AssetsConst.signInPurple),
          ),
          Positioned(
            top: 200,
            left: 30,
            child: SizedBox(
              width: 220,
              child: Text(
                S.of(context).titleLogin,
                style: AppTextStyles.largeHeading1().copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainSignIn(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: AppColors.defaultBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
        child: _buildLoginView(context),
      ),
    );
  }

  Widget _buildLoginView(BuildContext context) {
    return Form(
      key: controller.loginFormGlobalKey,
      onChanged: _formOnChange,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: const ValueKey('emailSignInField'),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              controller: controller.accountFieldController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.primaryColor,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
                LowerCaseTextFormatter(),
              ],
              focusNode: controller.accountNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.lightGrey,
                  size: 22,
                ),
                hintText: S.of(context).emailInput,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.white,
                  ),
                ),
                filled: true,
                fillColor: AppColors.white,
                errorMaxLines: 3,
              ),
              validator: (text) {
                return controller.accountValidation(text?.trim());
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('passwordSignInField'),
              maxLines: 1,
              obscureText: true,
              controller: controller.passwordFieldController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.primaryColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock_open_outlined,
                  size: 22,
                  color: AppColors.lightGrey,
                ),
                hintText: S.of(context).passwordInput,
                hintStyle: AppTextStyles.body1().copyWith(
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.white,
                  ),
                ),
                filled: true,
                fillColor: AppColors.white,
                errorMaxLines: 3,
              ),
              validator: controller.passwordValidation,
              onFieldSubmitted: (_) {
                if (controller.loginFormGlobalKey.currentState?.validate() ??
                    false) {
                  _signInOnClicked();
                }
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: Text.rich(
                TextSpan(
                    text: S.of(context).forgotPassword,
                    style: AppTextStyles.body2().copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _forgotPasswordOnClicked),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () {
                  return ElevatedButton(
                    key: const ValueKey('signInButton'),
                    style: controller.enableSignInBtn == true
                        ? FilledBtnStyle.enable(
                            sizeType: SizeButtonType.custom,
                            borderRadius: 16,
                            customPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                          )
                        : FilledBtnStyle.disable(
                            sizeType: SizeButtonType.custom,
                            borderRadius: 16,
                            customPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                          ),
                    onPressed: controller.enableSignInBtn == true
                        ? _signInOnClicked
                        : null,
                    child: Text(
                      S.of(context).signIn,
                      style: AppTextStyles.body1().copyWith(
                        color: AppColors.defaultBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).noAccount,
                        style: AppTextStyles.body2().copyWith(
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        text: S.of(context).signUp,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.blackColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _signupOnClicked,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
