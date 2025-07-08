import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ReviewOrderDetailsController extends GetxController {
  final TextEditingController couponController = TextEditingController();
  var steps = ['Review', 'Payment', 'Order Placed'].obs;
  var currentStep = 0.obs;
  var selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxDouble couponDiscount = 0.0.obs;

  var cartItmes = <Map<String, dynamic>>[].obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble newtotalAmount = 0.0.obs;
  var selectedItems = <Map<String, dynamic>>[].obs;

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

  void mycartApi() async {
    try {
      isLoading.value = true;
      var response = await ApiProvider().getRequest(apiUrl: 'cart/my-cart');
      if (response['success'] == true) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        cartItmes.assignAll(data);
        selectedItems.assignAll(data); 

        double total = 0;
        for (var item in data) {
          double price = double.tryParse(
                  item['price'].toString().replaceAll('₹', '').trim()) ??
              0;
          int qty = int.tryParse(item['qty'].toString()) ?? 1;
          total += price * qty;
        }
        totalAmount.value = total;
        // final data=response['data'];
        // cartItmes.assignAll(List<Map<String, dynamic>>.from(response['data']));
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
  void calculateTotal() {
    double total = 0;
    for (var item in selectedItems) {
      double price = double.tryParse(
              item['price'].toString().replaceAll('₹', '').trim()) ??
          0;
      int qty = int.tryParse(item['qty'].toString()) ?? 1;
      total += price * qty;
    }
    totalAmount.value = total;
    newtotalAmount.value = total - couponDiscount.value;
  }

  // void toggleItemSelection(Map<String, dynamic> item) {
  //   if (selectedItems.contains(item)) {
  //     selectedItems.remove(item);
  //   } else {
  //     selectedItems.add(item);
  //   }
  //   calculateTotal();
  // }


  void couponCodeApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {"coupon_code": couponController.value.text};
      var response =
          await ApiProvider().postRequest(apiUrl: 'apply-coupon', data: data);
      if (response['status'].toString() == 'success') {
        double discount = double.tryParse(response['discount'].toString()) ?? 0;
        couponDiscount.value = discount;
        newtotalAmount.value = totalAmount.value - couponDiscount.value;

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

  void deleteMyCartApi(String id) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "product_id": id,
      };
      var response = await ApiProvider()
          .postRequest(apiUrl: 'remove-from-cart', data: data);
      if (response['success'] == true) {
        mycartApi();
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
