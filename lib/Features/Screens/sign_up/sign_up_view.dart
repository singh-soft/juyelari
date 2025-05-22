import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  double relativeX(BuildContext context, double fraction) =>
      MediaQuery.of(context).size.width * fraction;
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpController());
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    final horizontalPadding = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              signupjewwpic,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              top: 100,
              left: screenWidth * 0.01,
              child: RotatingCircleAvatar(
                controller: controller.rotateController,
                imagePath: earingpic,
                radius: 27,
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              top: 150,
              left: screenWidth * 0.15,
              child: RotatingCircleAvatar(
                controller: controller.rotateController,
                imagePath: ringpic,
                radius: 35,
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              top: 170,
              left: screenWidth * 0.4,
              child: RotatingCircleAvatar(
                controller: controller.rotateController,
                imagePath: necklacepic,
                radius: 40,
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              top: 150,
              left: screenWidth * 0.65,
              child: RotatingCircleAvatar(
                controller: controller.rotateController,
                imagePath: thumbring,
                radius: 36,
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              top: 100,
              right: screenWidth * 0.01,
              child: RotatingCircleAvatar(
                controller: controller.rotateController,
                imagePath: diamondring,
                radius: 27,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height50,
                      Text(
                        "Register Now",
                        style: FontStyle.black18.copyWith(
                          fontSize: screenWidth > 600 ? 24 : 18,
                        ),
                      ),
                      height25,
                      CustomTextFormField(
                        hintText: 'Name',
                        topLabelText: 'Name',
                        isMandatory: true,
                        controller: controller.nameController,
                        hintStyle: FontStyle.black16.copyWith(
                          fontSize: screenWidth > 600 ? 20 : 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                      ),
                      height15,
                      CustomTextFormField(
                        hintText: 'Email',
                        topLabelText: 'Email',
                        isMandatory: true,
                        controller: controller.emailController,
                        hintStyle: FontStyle.black16.copyWith(
                          fontSize: screenWidth > 600 ? 20 : 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                      ),
                      height15,
                      CustomTextFormField(
                        hintText: 'Password',
                        topLabelText: 'Password',
                        isMandatory: true,
                        controller: controller.passwordController,
                        hintStyle: FontStyle.black16.copyWith(
                          fontSize: screenWidth > 600 ? 20 : 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                      ),
                      height15,
                      CustomTextFormField(
                        hintText: 'Confirm Password',
                        topLabelText: 'Confirm Password',
                        isMandatory: true,
                        controller: controller.confrmPasswordController,
                        hintStyle: FontStyle.black16.copyWith(
                          fontSize: screenWidth > 600 ? 20 : 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                      ),
                      height15,
                      CustomContainerButton(
                        padding: const EdgeInsets.all(12.0),
                        text: 'Register',
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height10,
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

class RotatingCircleAvatar extends StatelessWidget {
  final AnimationController controller;
  final String imagePath;
  final double radius;
  final Color backgroundColor;

  const RotatingCircleAvatar({
    super.key,
    required this.controller,
    required this.imagePath,
    required this.radius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.1,
              blurRadius: 0.1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: ClipOval(
            child: Image.asset(
              imagePath,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
