import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/forgot_password/create_password/create_password_screen.dart';
import 'package:juyelari/Features/Screens/login/login_view.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class OtpVerficationController extends GetxController
    with GetTickerProviderStateMixin {
  var emailget = Get.arguments;
  final TextEditingController otpcontroller = TextEditingController();
  late final AnimationController rotateController;
  var otpFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
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

    super.onClose();
  }

  void forgotpasswordVerifyOtpApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "email": emailget['email'],
        "otp": otpcontroller.value.text.trim(),
      };
      var response = await ApiProvider()
          .postRequest(apiUrl: 'forgot-password/verify-otp', data: data);
      print(response);
      if (response['status'] == true) {
        Get.to(() => const CreatePasswordScreen(), arguments: {
          "otp": otpcontroller.value.text,
          "email": emailget['email'],
        });
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = true;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value = true;
      }
    }
    on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException{
       CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    }
     catch (e) {
     CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
     
    }finally{
       isLoading.value = true;
    }
  }
}
