import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/field_validator.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/forgot_password/forgot_password.dart';
import 'package:juyelari/Features/Screens/login/login_controller.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customHeight100 = height100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());

    final screenWidth = MediaQuery.of(context).size.width;
     final screenheight = MediaQuery.of(context).size.height;
    // final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    // final horizontalPadding = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                 height: screenheight * 0.36,
                child: Image.asset(
                  loginpic,
                  height: 310,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Form(
                        key: controller.loginKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: FontStyle.black18,
                            ),
                            height25,
                            CustomTextFormField(
                                hintText: 'Email/Phone',
                                topLabelText: 'Email/Phone',
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.emailController,
                                hintStyle: FontStyle.black16,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                validator: (value) => FieldValidator(context)
                                    .emailValidate(value)),
                            height15,
                            Obx(()=>
                            CustomTextFormField(
                                  hintText: 'Password',
                                  topLabelText: 'Password',
                                  controller: controller.passwordController,
                                  hintStyle: FontStyle.black16,
                                  obscureText: controller.isPasswordVisibility.value,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  validator: (value) => FieldValidator(context)
                                      .passwordValidate(value),
                                      suffixIcon:
                                         IconButton(onPressed:controller.togglePasswordVisibility, 
                                        icon:Icon(controller.isPasswordVisibility.value?Icons.visibility_off:Icons.visibility)),
                                      
                                      ),
                            ),
                            height30,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomContainerButton(
                                    onTap: () {
                                      if (controller.loginKey.currentState!
                                          .validate()) {
                                        controller.loginApi();
                                      }
                                    // Get.to(() => const DashboardScreen());
                                   },
                                    width: screenWidth * 0.42,
                                    padding: const EdgeInsets.all(12.0),
                                    borderRadius: BorderRadius.circular(50),
                                    child: Center(
                                      child:
                                      Obx(()=>
                                         controller.isLoading.value?Center(
                                          child: LoadingAnimationWidget.flickr( size: 30, leftDotColor: Colors.white, rightDotColor: Colors.pink)): Text(
                                          'Login',
                                          style: FontStyle.white18,
                                        ),
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => const ForgotPassword());
                                    },
                                    child:
                                     Text("Forgot Password ?",
                                        style: TextStyle(
                                          color: CustomColor.redshadeColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        )))
                              ],
                            ),
                            height30,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Don’t have an account?',
                                    style: FontStyle.black16,
                                    children: [
                                      TextSpan(
                                        text: '  Register',
                                        style: FontStyle.redshade17,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => SignUpView());
                                          },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
