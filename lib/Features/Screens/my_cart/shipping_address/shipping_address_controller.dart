import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ShippingAddressController extends GetxController{
  final TextEditingController searchController=TextEditingController();
  var selectedAddressIndex=0.obs;
  List<Map<String,dynamic>> shippingAddress=[
    {
   'title': 'Shipping Address -2',
      'details': '26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city'
  },{
     'title': 'Shipping Address -4',
      'details': '26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city'
  },
  {
     'title': 'Shipping Address -5',
      'details': '26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city'
  }];
  void selectedAddress(int index){
    selectedAddressIndex.value=index;
  }

}