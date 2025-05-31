import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/forgot_password/forgot_password_controller.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  const ForgotPassword({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customHeight100 = height100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ForgotPasswordController());
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    final horizontalPadding = screenWidth * 0.07;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                loginpic,
                height: 310,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                top: 200,
                left: screenWidth * 0.008,
                child: RotatingCircleAvatar(
                  controller: controller.rotateController,
                  imagePath: earingpic,
                  radius: 27,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: 260,
                left: screenWidth * 0.15,
                child: RotatingCircleAvatar(
                  controller: controller.rotateController,
                  imagePath: ringpic,
                  radius: 35,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: 280,
                left: screenWidth * 0.4,
                child: RotatingCircleAvatar(
                  controller: controller.rotateController,
                  imagePath: necklacepic,
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: 260,
                left: screenWidth * 0.66,
                child: RotatingCircleAvatar(
                  controller: controller.rotateController,
                  imagePath: thumbring,
                  radius: 36,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: 210,
                right: screenWidth * 0.01,
                child: RotatingCircleAvatar(
                  controller: controller.rotateController,
                  imagePath: diamondring,
                  radius: 27,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                  top: 370,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Forgot Password", style: FontStyle.black18),
                            height10,
                            Text(
                              "Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.",
                              style: FontStyle.black16,
                            ),
                            height25,
                            CustomTextFormField(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              hintText: 'Email/Phone',
                              topLabelText: 'Email/Phone',
                              controller: controller.forgotPaawordController,
                              hintStyle: FontStyle.black16.copyWith(
                                fontSize: screenWidth > 600 ? 20 : 16,
                              ),
                            ),
                            height30,
                            CustomContainerButton(
                              // width: screenWidth * 0.6,
                              padding: const EdgeInsets.all(12.0),
                              text: 'Email Password Reset Link',
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
