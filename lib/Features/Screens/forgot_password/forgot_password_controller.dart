import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController with GetTickerProviderStateMixin{
  final TextEditingController forgotPaawordController=TextEditingController();
  late final AnimationController rotateController;
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