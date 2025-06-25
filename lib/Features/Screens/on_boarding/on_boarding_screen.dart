import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/on_boarding/on_boarding_screen_controller.dart';
import 'package:juyelari/Features/provider/auth.dart';
import 'package:juyelari/Features/res/routes/routes_name.dart';
import 'package:onboarding/onboarding.dart';

class OnBoardingScreen extends GetView<OnBoardingScreenController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OnBoardingScreenController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Onboarding(
        swipeableBody: [
          PageView(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.6,
                      child: Image.asset(
                        onboardingpic,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.5,
                      left: screenWidth * 0.009,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: earingpic,
                        radius: 27,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.54,
                      left: screenWidth * 0.17,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: ringpic,
                        radius: 35,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.565,
                      left: screenWidth * 0.42,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: necklacepic,
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.56,
                      left: screenWidth * 0.68,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: thumbring,
                        radius: 36,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.5,
                      right: screenWidth * 0.0,
                      child: RotatingCircleAvatar(
                        controller: controller.rotateController,
                        imagePath: diamondring,
                        radius: 27,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.72,
                      left: screenWidth * 0.3,
                      child: Image.asset(onboardinglogo),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        buildFooter: (context, netDragDistance, pagesLength, currentIndex,
            setIndex, slideDirection) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  if(token().toString().isNotEmpty){ 
                    Get.offAllNamed(RoutesName.dashboardscreen);}
                    else{
                      Get.offAllNamed(RoutesName.loginview);

                    }
                  
                },
                child: Text(
                  "Go To Next",
                  style: TextStyle(
                    color: CustomColor.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
