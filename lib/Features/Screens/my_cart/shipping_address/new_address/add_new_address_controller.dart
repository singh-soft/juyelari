import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_controller.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class AddNewAddressController extends GetxController {
  var saveAs = 'home'.obs;
  var isDefault = false.obs;
  RxBool isLoading=false.obs;
  var shippingAddressData=Get.arguments;
  var addressKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController1 = TextEditingController();
  final TextEditingController addressController2 = TextEditingController();
  final TextEditingController textareaController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final cartController = Get.find<MyCartController>();
  @override
void onInit() {
  super.onInit();
    
  if (shippingAddressData != null && shippingAddressData.isNotEmpty) {
    flatController.text = shippingAddressData['flat'] ?? '';
    areaController.text = shippingAddressData['area'] ?? '';
    addressController1.text = shippingAddressData['address_line_1'] ?? '';
    addressController2.text = shippingAddressData['address_line_2'] ?? '';
    cityController.text = shippingAddressData['city'] ?? '';
    stateController.text = shippingAddressData['state'] ?? '';
    countryController.text = shippingAddressData['country'] ?? '';
    pincodeController.text = shippingAddressData['postalcode'] ?? '';
    saveAs.value = shippingAddressData['address_tag'] ?? 'home';
     nameController.text = shippingAddressData['name'] ?? '';
    phoneController.text = shippingAddressData['phone'] ?? '';
  }
}

  void addnewAddressApi() async{
    try {
      Map<String, dynamic> data = {
        "name": nameController.value.text,
        "area":areaController.value.text,
        "phone":phoneController.value.text,
        "flat":flatController.value.text,
        "postalcode":pincodeController.value.text,
        "address_line_1":addressController1.value.text,
        "address_line_2":addressController2.value.text,
        "address_tag":saveAs.toString(),
        "city":cityController.value.text,
        "state":stateController.value.text,
        "country":countryController.value.text
      };
      isLoading.value=true;
     var response = await ApiProvider().postRequest(apiUrl: 'shipping-address',data: data);
     if (response['success'] == true) {
      nameController.clear();
      areaController.clear();
      phoneController.clear();
      flatController.clear();
      pincodeController.clear();
      addressController1.clear();
      addressController2.clear();
      cityController.clear();
      stateController.clear();
      countryController.clear();
       CustomWidgets().toast(response['message'], Colors.green);
       isLoading.value=false;
       Get.back(result: true);
     } else {
       CustomWidgets().toast(response['message'], Colors.red);
       isLoading.value=false;
     }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

   void updateAddressApi() async{
    try {
      Map<String, dynamic> data = {
        'id':shippingAddressData['id'],
        "name": nameController.value.text,
        "area":areaController.value.text,
        "phone":phoneController.value.text,
        "flat":flatController.value.text,
        "postalcode":pincodeController.value.text,
        "address_line_1":addressController1.value.text,
        "address_line_2":addressController2.value.text,
        "address_tag":saveAs.toString(),
        "city":cityController.value.text,
        "state":stateController.value.text,
        "country":countryController.value.text,
        
      };
      isLoading.value=true;
     var response = await ApiProvider().postRequest(apiUrl: 'shipping-address-update',data: data);
     if (response['success'] == true) {
      nameController.clear();
      areaController.clear();
      phoneController.clear();
      flatController.clear();
      pincodeController.clear();
      addressController1.clear();
      addressController2.clear();
      cityController.clear();
      stateController.clear();
      countryController.clear();
       CustomWidgets().toast(response['message'], Colors.green);
       
       isLoading.value=false;
       
       Get.back(result: true);
       
     } else {
       CustomWidgets().toast(response['message'], Colors.red);
       isLoading.value=false;
     }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
