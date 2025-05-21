import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrmPasswordController =
      TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController housenoController = TextEditingController();
  final TextEditingController addressnoController = TextEditingController();
}
