import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddressController extends GetxController {
   var saveAs = 'Home'.obs;
   var isDefault = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

void addnewAddressApi(){
  try {
    Map<String,dynamic> data={
      "name":nameController.value.text,
      
    };
    
  } catch (e) {
    
  }
}


}
