import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/otp_verification/otp_verfication_controller.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpVerificationScreen extends GetView<OtpVerficationController> {
  const OtpVerificationScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customHeight100 = height100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OtpVerficationController());
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    final horizontalPadding = screenWidth * 0.07;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
              Image.asset(
                forgotpasspic,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                top: 200,
                left: screenWidth * 0.007,
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
                left: screenWidth * 0.67,
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
              customHeight50,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customHeight100,
                    customHeight100,
                    Text("Otp Verfication", style: FontStyle.black18),
                    height10,
                    Text(
                      "We sent a reset link to alpha...@gmail.com  enter 5 digit code that mentioned in the email",
                      style: FontStyle.black16,
                    ),
                    height20,
                    Center(
                      child: PinCodeTextField(
                        controller: controller.otpcontroller,
                        maxLength: 6,
                        pinBoxWidth: 40,
                        pinBoxHeight: 50,
                        hasUnderline: false,
                        wrapAlignment: WrapAlignment.spaceAround,
                        highlight: true,
                        defaultBorderColor: Colors.grey,
                        highlightColor: Colors.blue,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    height50,
                    CustomContainerButton(
                      // width: screenWidth * 0.6,
                      padding: const EdgeInsets.all(12.0),
                      text: 'Verify Code',
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Haven’t got the email yet? ',
                              style: FontStyle.greyshade14,
                              children: [
                                TextSpan(
                                    text: 'Resend email',
                                    style: FontStyle.redshade14)
                              ]),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    ));
  }
}
