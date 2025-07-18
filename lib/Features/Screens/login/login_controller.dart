import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/bottom_bar/bottom_bar_view.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/provider/auth.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController rotateController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  var isPasswordVisibility=true.obs;
  void togglePasswordVisibility(){
    isPasswordVisibility.value=!isPasswordVisibility.value;
  }
  final box = GetStorage();
  void clearFormFields() {
    emailController.clear();
    passwordController.clear();
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
    passwordController.dispose();

    super.onClose();
  }

  void loginApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "email": emailController.value.text,
        "password": passwordController.value.text,
        "device_token": deviceToken().toString(),
        "device_type": deviceName().toString()
      };
      var response =
          await ApiProvider().postRequest(apiUrl: 'login', data: data);

      if (response['status'] == true) {
        box.write('access_token', response['access_token']);
        box.write('id', response['user']['id']);

        Get.offAll(() => const BottomBarView());
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value = false;
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
        isLoading.value = false;
    }
  }
}
