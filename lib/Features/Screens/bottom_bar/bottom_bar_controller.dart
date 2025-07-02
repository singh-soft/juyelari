import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_screen.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_screen.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/new_address/add_new_address_screen.dart';
import 'package:juyelari/Features/Screens/my_order_screen/my_order_screen.dart';

class BottomBarController extends GetxController{
  RxInt currentIndex=0.obs;
  void changeIndex(index){
    currentIndex.value=index;
  }
   List<Widget> pages = [
      const DashboardScreen(),
      const MyCartScreen(),
      const MyOrderScreen(),
      const AddNewAddressScreen(),
    ];
}