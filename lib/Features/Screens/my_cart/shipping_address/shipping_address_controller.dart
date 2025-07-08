import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var selectedAddressIndex = 0.obs;
  
  void selectedAddress(int index) {
    selectedAddressIndex.value = index;
  }

  
}
