import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin{
  late final AnimationController rotateController;
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
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
}