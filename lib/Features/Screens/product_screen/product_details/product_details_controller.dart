import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/provider/auth.dart';

class ProductDetailsController extends GetxController {
  RxList multipleImage = [].obs;
  RxList reviews = [].obs;
  RxMap allData = {}.obs;

  late final dynamic getProductId;

  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  RxBool isFavourite = false.obs;
  RxInt quantity = 1.obs;

  final staticAnchorKey = GlobalKey();
  RxBool showAllReviews = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProductId = Get.arguments;
    productDetailsApi();
  }

  void toggleReviews() {
    showAllReviews.value = !showAllReviews.value;
  }

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
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

      Map<String, dynamic> data = {
        "product_id": getProductId['product_id'],
        "user_id": userId(),
      };

      var response = await ApiProvider().postRequest(
        apiUrl: 'product-details',
        data: data,
      );

      if (response['status'] == true && response['data'] != null) {
        allData.value = response['data'];
        multipleImage.assignAll(List.from(response['data']['multi_images']));
        reviews.assignAll(List.from(response['data']['reviews'] ?? []));
        isFavourite.value = (response['data']['is_wishlist'] ?? 0) == 1;

        // CustomWidgets().toast(response['message'], Colors.green);
      } 
      // else {
      //   CustomWidgets().toast(response['message'], Colors.red);
      // }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets().toast("Request timed out. Please try again.", Colors.red);
    } catch (e) {
      CustomWidgets().toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void addtofavourite() async {
    try {
      isLoading.value = true;

      final previousValue = isFavourite.value;
      isFavourite.value = !previousValue;

      Map<String, dynamic> data = {
        "product_id": getProductId['product_id'],
        "is_like": !previousValue ? 1 : 0,
      };

      var response = await ApiProvider().postRequest(
        apiUrl: 'wishlist',
        data: data,
      );

      if (response['status'] == true) {
        CustomWidgets().toast(response['message'], Colors.green);
      } else {
        isFavourite.value = previousValue; 
        CustomWidgets().toast(response['message'], Colors.red);
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets().toast("Request timed out. Please try again.", Colors.red);
    } catch (e) {
      isFavourite.value = !isFavourite.value; 
      CustomWidgets().toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
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

      var response = await ApiProvider().postRequest(
        apiUrl: 'cart/add',
        data: data,
      );

      if (response['status'] == true) {
        Get.to(() => const MyCartScreen());
        CustomWidgets().toast(response['message'], Colors.green);
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets().toast("Request timed out. Please try again.", Colors.red);
    } catch (e) {
      CustomWidgets().toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
