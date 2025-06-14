import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/field_validator.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/forgot_password/create_password/create_password_controller.dart';
import 'package:juyelari/Features/Screens/login/login_view.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreatePasswordScreen extends GetView<CreatePasswordController> {
  const CreatePasswordScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customHeight100 = height100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePasswordController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
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
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(  horizontal: 30, vertical: 15),
                    child: Form(
                      key: controller.createPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create New Password", style: FontStyle.black18),
                          Text(
                            "Create a new password. Ensure it differs fromprevious ones for security",
                            style: FontStyle.black16,
                          ),
                          customHeight20, 
                           CustomTextFormField(
                                  hintText: ' New Password',
                                  topLabelText: 'New Password',
                                  isMandatory: true,
                                  controller: controller.newPasswordController,
                                  hintStyle: FontStyle.black16,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  validator: (value) => FieldValidator(context)
                                      .passwordValidate(value),
                                ),
                                customHeight20,
                                CustomTextFormField(
                                  hintText: 'Confirm Password',
                                  topLabelText: 'Confirm Password',
                                  isMandatory: true,
                                  controller: controller.confirmpasswordController,
                                  hintStyle: FontStyle.black16,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  validator: (value) => FieldValidator(context)
                                      .passwordValidate(value),
                                ),
                                customHeight50,
                                CustomContainerButton(
                                  onTap: (){
                                    if(controller.createPasswordFormKey.currentState!.validate()){
                                      controller.createNewPasswordResetApi();
                                    }
                                  },
                                  width: double.infinity,
                                   padding: const EdgeInsets.all(12.0),
                                      borderRadius: BorderRadius.circular(50),
                                  child: controller.isLoading.value?LoadingAnimationWidget.flickr(size: 30, leftDotColor: Colors.white, rightDotColor: Colors.pink):Text("Save Password", style: FontStyle.white18,textAlign: TextAlign.center,),
                                )
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ))
                ],
              ),
        ));
  }
}
