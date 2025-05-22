import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController  with GetTickerProviderStateMixin{
  late final AnimationController rotateController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrmPasswordController =
      TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController housenoController = TextEditingController();
  final TextEditingController addressnoController = TextEditingController();
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
}
