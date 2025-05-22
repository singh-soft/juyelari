import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/login/login_controller.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';

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
    final verticalPadding = screenWidth > 600 ? 250.0 : 200.0;
    final horizontalPadding = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                loginpic,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height100,
                    height100,
                    Text("Welcome", style: FontStyle.black18),
                    height25,
                    CustomTextFormField(
                      hintText: 'Email/Phone',
                      topLabelText: 'Email/Phone',
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
                      controller: controller.passwordController,
                      hintStyle: FontStyle.black16.copyWith(
                        fontSize: screenWidth > 600 ? 20 : 16,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                    ),
                    height20,
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomContainerButton(
                          width: screenWidth*0.4,
                          
                        padding: const EdgeInsets.all(12.0),
                        text: 'Login',
                        borderRadius: BorderRadius.circular(50),
                      ),
                      Text("Forgot Password ?",style: FontStyle.redshade16,)

                      ],
                    ),
                    height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                            RichText(
                      text: TextSpan(
                      text: 'Don’t have an account?',style: FontStyle.black16,
                      children: [
                       
                        
                        TextSpan(text: '      Register',style: FontStyle.redshade17)
                      ]
                    ),
                    
                    )
                      ],
                    )
                    
                   
                      
                  ],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
