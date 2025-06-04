import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/res/routes/routes_name.dart';

class SignUpController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController rotateController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrmPasswordController =
      TextEditingController();
  final TextEditingController addressOneController = TextEditingController();
  final TextEditingController addressTwoController = TextEditingController();
  final TextEditingController addressnoController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  var signUpKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  void clearFormFields() {
  nameController.clear();
  emailController.clear();
  mobileController.clear();
  passwordController.clear();
  confrmPasswordController.clear();
  addressOneController.clear();
  addressTwoController.clear();
  postalCodeController.clear();
  areaController.clear();
  flatNoController.clear();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confrmPasswordController.dispose();
    addressnoController.dispose();
    super.onClose();
  }

  void signupApi() async {
    try {
        isLoading.value = true;
      Map<String, dynamic> data = {
        "name": nameController.value.text.toString(),
        "email": emailController.value.text.toString(),
        "mobile": mobileController.value.text,
        "password": passwordController.value.text,
        "password_confirmation": confrmPasswordController.value.text,
        "address_line_1": addressOneController.value.text,
        "address_line_2": addressTwoController.value.text,
        "postalcode": postalCodeController.value.text,
        "area": areaController.value.text,
        "flat": flatNoController.value.text,
      };
      var response =
          await ApiProvider().postRequest(apiUrl: 'register', data: data);
      if (response['status']==true) {
        clearFormFields();
        Get.toNamed(RoutesName.loginview, arguments: data);
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
