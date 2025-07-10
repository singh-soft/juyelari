import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/field_validator.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({super.key});

  double relativeX(BuildContext context, double fraction) =>
      MediaQuery.of(context).size.width * fraction;
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
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
              Positioned(
                top: 260,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Form(
                        key: controller.signUpKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register Now",
                              style: FontStyle.black18,
                            ),
                            height25,
                            CustomTextFormField(
                              hintText: 'Name',
                              topLabelText: 'Name',
                              isMandatory: true,
                              controller: controller.nameController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).nameValidate(value),
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Email',
                              topLabelText: 'Email',
                              isMandatory: true,
                              controller: controller.emailController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).emailValidate(value),
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Phone Number',
                              topLabelText: 'Phone Number',
                              isMandatory: true,
                              controller: controller.mobileController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) =>
                                  FieldValidator(context).mobileValidate(value),
                            ),
                            height15,
                            Obx(()=>
                              CustomTextFormField(
                                hintText: 'Password',
                                topLabelText: 'Password',
                                isMandatory: true,
                                controller: controller.passwordController,
                                hintStyle: FontStyle.black16,
                                obscureText: controller.isPasswordVisibility.value,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                validator: (value) => FieldValidator(context)
                                    .passwordValidate(value),
                                    suffixIcon: IconButton(onPressed: controller.togglePasswordVisibility, 
                                    icon: Icon(controller.isPasswordVisibility.value?Icons.visibility_off:Icons.visibility)),
                              ),
                            ),
                            height15,
                            Obx(()=>
                               CustomTextFormField(
                                hintText: 'Confirm Password',
                                topLabelText: 'Confirm Password',
                                isMandatory: true,
                                controller: controller.confrmPasswordController,
                                hintStyle: FontStyle.black16,
                                 obscureText: controller.isConfirmPasswordVisibility.value,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                validator: (value) => FieldValidator(context)
                                    .confirmPasswordValidate1(value,
                                        controller.passwordController.text),
                                         suffixIcon: IconButton(onPressed: controller.toggleConfirmPasswordVisibility, 
                                    icon: Icon(controller.isConfirmPasswordVisibility.value?Icons.visibility_off:Icons.visibility)),
                              ),
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Address Line 1',
                              topLabelText: 'Address Line 1',
                              isMandatory: true,
                              controller: controller.addressOneController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).addressLine1(value),
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Address Line 2',
                              topLabelText: 'Address Line 2',
                              isMandatory: false,
                              controller: controller.addressTwoController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Postal Code',
                              topLabelText: 'Postal Code',
                              isMandatory: true,
                              controller: controller.postalCodeController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).postalCode(value),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            height15,
                            CustomTextFormField(
                              hintText: 'Area',
                              topLabelText: 'Area',
                              isMandatory: true,
                              controller: controller.areaController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).area(value),
                            ),
                            height15,       
                            CustomTextFormField(
                              hintText: 'Flat No',
                              topLabelText: 'Flat No',
                              isMandatory: true,
                              controller: controller.flatNoController,
                              hintStyle: FontStyle.black16,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              validator: (value) =>
                                  FieldValidator(context).flat(value),
                            ),
                            height50,
                            Center(
                                child: CustomContainerButton(
                                  width: double.infinity,
                                  onTap: () {
                                    if (controller.signUpKey.currentState!
                                        .validate()) {
                                      controller.signupApi();
                                    }
                                  },
                                  padding: const EdgeInsets.all(12.0),
                                  borderRadius: BorderRadius.circular(50),
                                  child: Obx(()=>
                                     controller.isLoading.value
                                        ? Center(
                                          child: LoadingAnimationWidget.flickr(
                                               size: 30, leftDotColor: Colors.white, rightDotColor: Colors.pink),
                                        )
                                        : Center(
                                            child: Text(
                                            'Register',
                                            style: FontStyle.white18,
                                          )),
                                  ),
                                ),
                              ),
                            
                            height10,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
