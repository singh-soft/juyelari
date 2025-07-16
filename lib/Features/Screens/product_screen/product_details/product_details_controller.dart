import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ProductDetailsController extends GetxController {
  RxList multipleImage = [].obs;
  var getimage = Get.arguments;
  var gettitle = Get.arguments;
  var getProductId = Get.arguments;
  var allData = {}.obs;
  RxList reviews = [].obs;
  final staticAnchorKey = GlobalKey();
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  var quantity = 1.obs;
  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
  }

  RxBool showAllReviews = false.obs;

  void toggleReviews() {
    showAllReviews.value = !showAllReviews.value;
  }

  List<Map<String, dynamic>> similaritemdetails = [
    {
      'image': 'assets/images/tanishqear.webp',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picerarneck.webp',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picnecklace1.jpg',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picearring.jpg',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
  ];
  void productDetailsApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {"product_id": getProductId['product_id']};

      var response = await ApiProvider()
          .postRequest(apiUrl: 'product-details', data: data);

      if (response['status'] == true && response['data'] != null) {
        allData.value = response['data'];
        multipleImage.assignAll(List.from(response['data']['multi_images']));
        reviews.assignAll(List.from(response['data']['reviews'] ?? []));

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

  void addtocartApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "product_id": getProductId['product_id'],
        "qty": quantity.value,
        "price": allData['price'],
      };
      print("dddddddddddddddddd " + data.toString());
      var response =
          await ApiProvider().postRequest(apiUrl: 'cart/add', data: data);
      print(response);
      if (response['status'] == true) {
        Get.to(() => const MyCartScreen());
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
