import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAddressController extends GetxController {
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
}
