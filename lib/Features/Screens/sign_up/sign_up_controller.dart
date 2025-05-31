import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:juyelari/Features/Screens/otp_verification/otp_verification_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

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
  void signupApi()async{
    try {
      Map<String,dynamic> data={
        "name":nameController.value.text.toString(),
        "email":emailController.value.text.toString(),
        "password":passwordController.value.text,
        "password_confirmation":confrmPasswordController.value.text,
        "address_line_1":"Near  by dcm jaipur",
        "address_line_2":"200 feet by pass Jaipur",
        "postalcode":"305200",
        "area":"Jaipur",
        "flat":"201",
         };

         print(data);

      var response=await ApiProvider().postRequest(apiUrl: 'register',data: data);
      if(response['status']==true){

          print(response);
          Get.to(()=>OtpVerificationScreen());
      }else {

      }
      
    } catch (e) {
      print(e.toString());
    }

  }
}
