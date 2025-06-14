import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/provider/auth.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController rotateController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
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
        Get.to(() => const DashboardScreen());
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value = false;
      }
    } catch (e) {
      CustomWidgets().toast(e.toString(), Colors.red);
      isLoading.value = false;
    }
  }
}
