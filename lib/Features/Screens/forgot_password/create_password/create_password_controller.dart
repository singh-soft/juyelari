import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/login/login_view.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class CreatePasswordController extends GetxController with GetTickerProviderStateMixin{
  late final AnimationController rotateController;
  
  final TextEditingController newPasswordController=TextEditingController();
  final TextEditingController confirmpasswordController=TextEditingController();
  var createPasswordFormKey=GlobalKey<FormState>();
  late final String email;
  late final String otp;
  RxBool isLoading=false.obs;
  @override
   void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    email = args['email'];
    otp = args['otp'];
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
  void createNewPasswordResetApi()async{
    try {
      isLoading.value=true;
      Map<String,dynamic> data={
      "email":email,
      "otp":otp,
      "password":newPasswordController.value.text,
      "password_confirmation":confirmpasswordController.value.text
      };
      var response=await ApiProvider().postRequest(apiUrl: 'forgot-password/reset',data: data);
      if(response['status']==true){
        Get.to(()=> const LoginView());
        CustomWidgets().toast(response['message'], Colors.green);
         isLoading.value=false;
      }else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value=false;
      }
    } catch (e) {
       CustomWidgets().toast(e.toString(), Colors.red);
      isLoading.value = false;
      
    }

  }

}