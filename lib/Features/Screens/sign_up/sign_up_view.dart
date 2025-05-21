import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Image.asset(
                      signupjellwpic,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       customHeight25,
                      Text(
                        "Register Now",
                        style: FontStyle.black18,
                      ),
                      customHeight25,
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        hintText: 'Name',
                        topLabelText: 'Name',
                        isMandatory: true,
                        hintStyle: FontStyle.black16,
                        controller: controller.nameController,
                      ),
                      customHeight15,
                      CustomTextFormField(
                         contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        hintText: 'Email',
                        topLabelText: 'Email',
                        isMandatory: true,
                        hintStyle: FontStyle.black16,
                        controller: controller.emailController,
                      ),
                      customHeight15,
                      CustomTextFormField(
                         contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        hintText: 'Password',
                        topLabelText: 'Password',
                        isMandatory: true,
                        hintStyle: FontStyle.black16,
                        controller: controller.passwordController,
                      ),
                      customHeight15,
                      CustomTextFormField(
                         contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        hintText: 'Confirm Password',
                        topLabelText: 'Confirm Password',
                        isMandatory: true,
                        hintStyle: FontStyle.black16,
                        controller: controller.confrmPasswordController,
                      ),
                      customHeight15,

                      CustomTextFormField(
                         contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        hintText: 'Address Line 1',
                        topLabelText: 'Address Line 1',
                        hintStyle: FontStyle.black16,
                        controller: controller.addressnoController,
                      ),
                      customHeight20,
                      CustomContainerButton(
                        
                          padding: const EdgeInsets.all(12.0),
                          text: 'Register',
                          borderRadius: BorderRadius.circular(50)),
                     
                    ],
                  ),
                ),
                 Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.copyright,
                            color: CustomColor.greycolor,
                            size: 16,
                          ),
                          Text(
                            "2025 www.singhsoft.com. All Right Reserved.",
                            style: FontStyle.greycolor16,
                          )
                        ],
                      ),
              ],
            ),
          )),
    );
  }
}
