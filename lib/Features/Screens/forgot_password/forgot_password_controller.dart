import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/otp_verification/otp_verification_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ForgotPasswordController extends GetxController
    with GetTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  late final AnimationController rotateController;
  var forgotpasswordKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  void clearFormFields() {
    emailController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void onClose() {
    rotateController.dispose();
    emailController.dispose();

    super.onClose();
  }

  void forgotPasswordSendOtpApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "email": emailController.value.text,
      };
      var response = await ApiProvider()
          .postRequest(apiUrl: 'forgot-password/send-otp', data: data);
      if (response['status'] == true) {
        Get.to(() => const OtpVerificationScreen(),
            arguments: {"email": emailController.value.text});

        CustomWidgets().toast(response['message'], Colors.green);

        isLoading.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        CustomWidgets().toast(response['message'], Colors.red);

        if (response['errors'] != null &&
            response['errors']['email'] != null &&
            response['errors']['email'].isNotEmpty) {
          CustomWidgets().toast(response['errors']['email'][0], Colors.red);
        }
        isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
      CustomWidgets().toast(e.toString(), Colors.red);
      isLoading.value = false;
    }
  }
}
