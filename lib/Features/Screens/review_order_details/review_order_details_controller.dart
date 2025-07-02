import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ReviewOrderDetailsController extends GetxController {
  final TextEditingController couponController = TextEditingController();
  var steps = ['Review', 'Payment', 'Order Placed'].obs;
  var currentStep = 0.obs;
  var selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  final List<Map<String, String>> products = [
    {
      'title': 'Classic Gold Bangle with Leaf Design',
      'price': '₹ 1749',
      'image': 'assets/images/necklacepic.png',
      'size': 'Free Size',
      'qty': '1',
      'return': 'All Issue easy returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/thumbring.png',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
  ];

  var isReviewDone = false.obs;

  void completeReview() {
    isReviewDone.value = true;
  }

  void nextStep() {
    if (canGoToStep(currentStep.value + 1)) {
      currentStep++;
    }
  }

  void previousStep() {
    if (currentStep > 0) currentStep--;
  }

  void goToStep(int index) {
    if (canGoToStep(index)) {
      currentStep.value = index;
    }
  }

  bool canGoToStep(int index) {
    if (index == 1 || index == 2) {
      return isReviewDone.value;
    }
    return index <= steps.length - 1;
  }

  void couponCodeApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {"coupon_code": couponController.value.text};
      var response =
          await ApiProvider().postRequest(apiUrl: 'apply-coupon', data: data);
      if (response['status'] == true) {
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value = false;
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
