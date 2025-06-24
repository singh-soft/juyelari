import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/login/login_view.dart';
import 'package:juyelari/Features/Screens/on_boarding/on_boarding_screen_controller.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:onboarding/onboarding.dart';

class OnBoardingScreen extends GetView<OnBoardingScreenController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OnBoardingScreenController());
    final screenWidth = MediaQuery.of(context).size.width;

    // final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    // final horizontalPadding = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Onboarding(
        swipeableBody: [
          PageView(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Image.asset(
                      onboardingpic,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 360,
                      left: screenWidth * 0.007,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: earingpic,
                        radius: 27,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 420,
                      left: screenWidth * 0.15,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: ringpic,
                        radius: 35,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 420,
                      left: screenWidth * 0.42,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: necklacepic,
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 420,
                      left: screenWidth * 0.69,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: thumbring,
                        radius: 36,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 360,
                      right: screenWidth * 0.01,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: diamondring,
                        radius: 27,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                        top: 600,
                        left: screenWidth * 0.3,
                        child: Image.asset(onboardinglogo)),
                  ],
                ),
              ),
            ],
          )
        ],
        buildFooter: (context, netDragDistance, pagesLength, currentIndex,
            setIndex, slideDirection) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(()=> const  LoginView());
                    },
                    child:  Text(
                      "Go To Next",
                      style: TextStyle(color: CustomColor.blackColor, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
                    )),
              ),
            ],
          );
        },
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

